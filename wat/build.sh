#!/bin/bash

set -e
set -x

cargo build --release --target=x86_64-unknown-linux-musl
cp target/x86_64-unknown-linux-musl/release/wat .
