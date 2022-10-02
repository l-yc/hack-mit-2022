
all: ./src/lib.rs
	cargo build-bpf --manifest-path=./Cargo.toml --bpf-out-dir=program

deploy:
	solana program deploy program/helloworld.so
