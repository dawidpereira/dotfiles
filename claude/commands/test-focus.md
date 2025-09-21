---
title: "Run Focused Tests"
description: "Run tests relevant to current changes"
---

# Run Focused Tests

Intelligently run tests based on the current working directory and recent changes:

1. **Detect project type:**
   - Look for `Cargo.toml` (Rust project)
   - Look for `*.csproj` or `*.sln` (.NET project)
   - Look for `package.json` (Node.js project)
   - Look for `requirements.txt` or `pyproject.toml` (Python project)

2. **For Rust projects:**
   - If arguments provided, run specific test: `cargo test $ARGUMENTS`
   - If no arguments, detect recent changes and run relevant tests:
     - `cargo test --lib` for library tests
     - `cargo test --bin [binary_name]` for binary tests
     - `cargo test [module_name]` for specific modules
   - Use `cargo test -- --nocapture` to show println! output
   - Run with `--release` flag if performance testing is needed

3. **For .NET projects:**
   - If arguments provided, run specific test: `dotnet test --filter $ARGUMENTS`
   - If no arguments, run based on recent changes:
     - `dotnet test --filter "Category=Unit"` for unit tests
     - `dotnet test --filter "Category=Integration"` for integration tests
     - `dotnet test [ProjectName]` for specific test projects
   - Use `--logger "console;verbosity=detailed"` for detailed output
   - Generate code coverage with `--collect:"XPlat Code Coverage"`

4. **For Node.js projects:**
   - Run `npm test` or `yarn test` with appropriate filters
   - If Jest: `npm test -- --testNamePattern="$ARGUMENTS"`
   - For specific files: `npm test -- [file_pattern]`

5. **For Python projects:**
   - Run `pytest $ARGUMENTS` if arguments provided
   - Otherwise run `pytest -v` for verbose output
   - Use `pytest --cov` for coverage reports
   - Run `pytest -k [keyword]` for pattern matching

6. **Test execution strategy:**
   - Run fast unit tests first
   - Show clear pass/fail summary
   - If tests fail, display relevant error messages
   - Suggest next steps based on failure types

7. **Performance considerations:**
   - Use parallel execution when available
   - Skip slow integration tests unless specifically requested
   - Cache test results when possible

8. **Post-test actions:**
   - Display test coverage if available
   - Show performance metrics for slow tests
   - Suggest relevant tests to run next based on failures

If no project type is detected, ask the user to specify the testing framework and command to use.
