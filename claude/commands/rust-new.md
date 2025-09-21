---
title: "Create New Rust Project"
description: "Initialize a new Rust project with best practices"
---

# Create New Rust Project

Create a new Rust project with the following setup:

1. Initialize with `cargo new $ARGUMENTS` (use the first argument as project name)
2. Add common development dependencies to Cargo.toml:
   - `serde = { version = "1.0", features = ["derive"] }` for serialization
   - `tokio = { version = "1.0", features = ["full"] }` for async runtime
   - `anyhow = "1.0"` for error handling
   - `clap = { version = "4.0", features = ["derive"] }` for CLI parsing
   - `tracing = "0.1"` for logging
   - `tracing-subscriber = "0.3"` for log formatting

3. Add development dependencies:
   - `criterion = "0.5"` for benchmarking

4. Set up project structure:
   - Create `src/lib.rs` if it's a library
   - Add basic error types using `thiserror`
   - Set up `tracing` for logging
   - Add `.gitignore` for Rust projects
   - Create basic `README.md`

5. Configure Cargo.toml with:
   - Appropriate edition (2021)
   - License information
   - Author information
   - Basic metadata

6. Add common clippy lints in `src/main.rs` or `src/lib.rs`:
```rust
#![warn(clippy::all, clippy::pedantic)]
#![allow(clippy::missing_errors_doc)]
```

7. Run initial checks:
   - `cargo fmt`
   - `cargo clippy`
   - `cargo test`
   - `cargo build`

Ask me to confirm the project name and any specific requirements before proceeding.
