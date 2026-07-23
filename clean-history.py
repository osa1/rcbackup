#!/usr/bin/env python3
"""Drop noisy commands from the zsh history files.

zsh's HISTORY_IGNORE only filters commands as they are written, so this is for
cleaning out what is already on disk: the global history file and every
per-directory history under ~/.directory_history.

Every dropped command is printed. Nothing is written unless --apply is given,
and then each file is copied to <file>.bak first, unless --no-backup says not to.
"""

import argparse
import re
import shutil
import sys
from pathlib import Path

# Same set the .zshrc HISTORY_IGNORE uses. Override with --commands.
DEFAULT_COMMANDS = (
    "ls,ll,cd,cdr,pwd,clear,cat,fg,mv,man,jobs,nvim,vim,"
    "git,tig,gs,gst,gd,gdc,gb,gcb,gp,gpom,ga,gam,gm,"
    "htop,top"
)

# extended_history writes each entry as ": <start>:<elapsed>;<command>".
TIMESTAMP = re.compile(r"^: \d+:\d+;")

# History files can contain arbitrary bytes. surrogateescape round-trips
# whatever is not valid UTF-8, so untouched entries are rewritten unchanged.
IO_ARGS = {"encoding": "utf-8", "errors": "surrogateescape", "newline": ""}


def build_pattern(commands):
    """Match a command line that starts with one of `commands`.

    The command name has to be followed by whitespace or the end of the line, so
    `gd` does not also match `gdb -q`.
    """
    alternatives = "|".join(re.escape(command) for command in commands)
    return re.compile(rf"(?:{alternatives})(?:\s|\Z)")


def split_entries(text):
    """Split file contents into entries, each a list of physical lines.

    An embedded newline is stored as a backslash followed by a real newline, so
    a line ending in a backslash continues onto the next one.
    """
    if not text:
        return
    if text.endswith("\n"):
        text = text[:-1]

    entry = []
    for line in text.split("\n"):
        entry.append(line)
        if not line.endswith("\\"):
            yield entry
            entry = []
    if entry:
        yield entry


def command_of(entry):
    """Reconstruct the command an entry holds, without timestamp or escaping."""
    lines = [TIMESTAMP.sub("", entry[0], count=1)] + entry[1:]
    # Every line but the last ends with the backslash standing in for a newline.
    return "\n".join([line[:-1] for line in lines[:-1]] + [lines[-1]])


def clean_file(path, pattern, apply, show_commands, backup):
    """Drop matching entries from `path`. Returns (entries seen, entries dropped).

    Only rewrites the file when `apply` is set, and only when something matched.
    """
    with open(path, **IO_ARGS) as f:
        text = f.read()

    kept_lines, entries, dropped = [], 0, 0
    for entry in split_entries(text):
        entries += 1
        command = command_of(entry)
        if pattern.match(command):
            dropped += 1
            if show_commands:
                print(f"  - {command}")
        else:
            # Kept entries are written back verbatim, never re-encoded.
            kept_lines.extend(entry)

    if dropped and apply:
        if backup:
            shutil.copy2(path, path.with_name(path.name + ".bak"))
        # Truncating in place keeps the file's mode: history is 0600.
        with open(path, "w", **IO_ARGS) as f:
            f.write("".join(line + "\n" for line in kept_lines))

    return entries, dropped


def main():
    parser = argparse.ArgumentParser(
        description=__doc__,
        formatter_class=argparse.RawDescriptionHelpFormatter,
    )
    parser.add_argument(
        "--apply", action="store_true",
        help="rewrite the history files (default: report only)",
    )
    parser.add_argument(
        "--summary", action="store_true",
        help="print counts only, not each dropped command",
    )
    parser.add_argument(
        "--no-backup", action="store_true",
        help="with --apply, rewrite in place without keeping a <file>.bak copy",
    )
    parser.add_argument(
        "--commands", default=DEFAULT_COMMANDS, metavar="LIST",
        help="comma separated commands to drop (default: %(default)s)",
    )
    parser.add_argument(
        "--histfile", type=Path, default=Path.home() / ".history-zsh",
        help="global history file (default: %(default)s)",
    )
    parser.add_argument(
        "--history-base", type=Path, default=Path.home() / ".directory_history",
        help="per-directory history root (default: %(default)s)",
    )
    args = parser.parse_args()

    # Entries read with surrogateescape can hold bytes that are not valid UTF-8,
    # and printing those to a strict stdout raises UnicodeEncodeError. Echo them
    # back as the original bytes instead.
    sys.stdout.reconfigure(errors="surrogateescape")
    sys.stderr.reconfigure(errors="surrogateescape")

    commands = [c.strip() for c in args.commands.split(",") if c.strip()]
    if not commands:
        sys.exit("no commands given")
    pattern = build_pattern(commands)

    targets = []
    if args.histfile.is_file():
        targets.append(args.histfile)
    if args.history_base.is_dir():
        targets += sorted(p for p in args.history_base.rglob("history") if p.is_file())
    if not targets:
        sys.exit("no history files found")

    total_entries = total_dropped = files_changed = 0
    for path in targets:
        if not args.summary:
            print(f"{path}:")

        entries, dropped = clean_file(
            path, pattern, args.apply, not args.summary, not args.no_backup
        )
        total_entries += entries
        total_dropped += dropped

        if dropped:
            files_changed += 1
            if args.summary:
                print(f"{path}: {dropped} dropped")
        elif not args.summary:
            print("  (nothing to drop)")

    print()
    print(f"scanned {len(targets)} file(s), {total_entries} entries")
    print(f"dropped {total_dropped} entries across {files_changed} file(s)")
    if args.apply:
        if files_changed and args.no_backup:
            print(f"rewrote {files_changed} file(s), no backups kept")
        elif files_changed:
            print(f"rewrote {files_changed} file(s), backups at <file>.bak")
    else:
        print("dry run: nothing written. re-run with --apply")


if __name__ == "__main__":
    main()
