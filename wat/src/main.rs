use std::path::{Path, PathBuf};
use std::process::Command;
use std::{env, fs, io, process};

use rayon::prelude::*;

fn main() {
    let wd = match env::current_dir() {
        Ok(wd) => wd,
        Err(err) => {
            println!("Unable to get working directory: {}", err);
            process::exit(1);
        }
    };

    let mut files = vec![];
    walk_dir(wd, &mut files);

    files.par_iter().for_each(|in_path| {
        println!("{}", in_path.to_string_lossy());

        let out_path = {
            let mut out_path = in_path.clone();
            let _ = out_path.set_extension("wat");
            out_path
        };

        let output = Command::new("wasm2wat")
            .arg("--enable-all")
            .arg(in_path)
            .arg("-o")
            .arg(out_path)
            .output();

        let _ = report_cmd_out(in_path, "wasm2wat", output);

        let output = Command::new("wasm-objdump").arg("-d").arg(in_path).output();

        if let Some(output) = report_cmd_out(in_path, "wasm-objdump", output) {
            let out_path = {
                let mut out_path = in_path.clone();
                let _ = out_path.set_extension("wasm-objdump");
                out_path
            };
            match fs::write(&out_path, output.stdout) {
                Ok(()) => {}
                Err(err) => {
                    println!(
                        "Error while writing wasm-objdump output to file {}: {}",
                        out_path.to_string_lossy(),
                        err
                    );
                }
            }
        }
    });
}

fn report_cmd_out(
    path: &Path,
    pgm: &str,
    ret: io::Result<process::Output>,
) -> Option<process::Output> {
    match ret {
        Ok(ret) => {
            if ret.status.success() {
                Some(ret)
            } else {
                println!(
                    "Unexpected return value while running {} on {}: {:?}",
                    pgm,
                    path.to_string_lossy(),
                    ret
                );
                None
            }
        }
        Err(err) => {
            println!(
                "Error while running {} on {}: {}",
                pgm,
                path.to_string_lossy(),
                err
            );
            None
        }
    }
}

fn walk_dir(dir: PathBuf, files: &mut Vec<PathBuf>) {
    let dir_contents = match fs::read_dir(&dir) {
        Ok(dir_contents) => dir_contents,
        Err(err) => {
            println!(
                "Unable to read contents of {}: {}",
                dir.to_string_lossy(),
                err
            );
            return;
        }
    };

    for file in dir_contents {
        let file = match file {
            Ok(file) => file,
            Err(err) => {
                println!(
                    "Unable to get details of a file in {}: {}",
                    dir.to_string_lossy(),
                    err
                );
                return;
            }
        };

        let file_path = file.path();
        if let Some(ext) = file_path.extension() {
            if ext == "wasm" {
                let path = {
                    let mut path = dir.clone();
                    path.push(file.path());
                    path
                };

                files.push(path);
            }
        }

        match file_path.metadata() {
            Ok(metadata) => {
                if metadata.is_dir() {
                    let mut path = dir.clone();
                    path.push(file.path());
                    walk_dir(path, files);
                }
            }
            Err(err) => {
                let mut full_path = dir.clone();
                full_path.push(file_path);
                println!(
                    "Can't get metadata of {}: {}",
                    full_path.to_string_lossy(),
                    err
                );
            }
        }
    }
}
