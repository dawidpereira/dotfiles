---
title: "Comprehensive Code Review"
description: "Perform a thorough code review of recent changes"
---

# Comprehensive Code Review

Perform a detailed code review focusing on recent changes or specified files:

## 1. **Change Detection:**

- If `$ARGUMENTS` provided, review specific files/directories
- Otherwise, detect recent changes:
  - `git diff --name-only HEAD~1` for last commit
  - `git diff --name-only main..HEAD` for branch changes
  - `git status --porcelain` for uncommitted changes

## 2. **Code Quality Analysis:**

**Architecture & Design:**
- Review code organization and structure
- Check for proper separation of concerns
- Evaluate design patterns usage
- Assess modularity and coupling
- Review naming conventions

**Performance Considerations:**
- Identify potential performance bottlenecks
- Review algorithm complexity
- Check for unnecessary allocations
- Evaluate database query efficiency
- Look for concurrency issues

**Error Handling:**
- Check error propagation patterns
- Review exception handling strategies
- Validate input sanitization
- Assess graceful degradation

## 3. **Language-Specific Reviews:**

**For Rust:**
- Check ownership and borrowing patterns
- Review lifetime annotations
- Validate error handling with `Result<T, E>`
- Check for unnecessary `clone()` calls
- Review `unsafe` code blocks
- Validate thread safety
- Check for panic conditions

**For .NET/C#:**
- Review async/await patterns
- Check for proper disposal (`using` statements)
- Validate nullable reference type usage
- Review LINQ performance
- Check for memory leaks
- Validate exception handling
- Review dependency injection patterns

**For JavaScript/TypeScript:**
- Check for type safety issues
- Review async/await vs Promises
- Validate error boundaries
- Check for memory leaks
- Review state management patterns
- Validate input sanitization

## 4. **Security Review:**

- Check for injection vulnerabilities
- Review authentication and authorization
- Validate input sanitization
- Check for sensitive data exposure
- Review cryptographic implementations
- Assess logging of sensitive information

## 5. **Testing Coverage:**

- Evaluate test coverage for new code
- Review test quality and assertions
- Check for edge case testing
- Validate integration test coverage
- Review mock and stub usage
- Assess test maintainability

## 6. **Documentation Review:**

- Check for adequate code comments
- Review API documentation
- Validate README updates
- Check for inline documentation
- Review changelog entries
- Assess code examples

## 7. **Dependency Management:**

- Review new dependencies
- Check for version conflicts
- Validate license compatibility
- Assess maintenance status
- Review security implications

## 8. **Code Style & Conventions:**

- Check formatting consistency
- Review naming conventions
- Validate project structure
- Check for code duplication
- Review import/using statements
- Assess code readability

## 9. **Integration & Compatibility:**

- Check backward compatibility
- Review API contract changes
- Validate configuration changes
- Check for breaking changes
- Review migration requirements

## 10. **Reporting:**

Provide structured feedback with:
- **Critical Issues:** Must fix before merge
- **Important Issues:** Should fix for quality
- **Suggestions:** Nice-to-have improvements
- **Positive Feedback:** Well-implemented features

For each issue, include:
- File location and line number
- Problem description
- Suggested solution
- Priority level
- Code examples where helpful

## 11. **Action Items:**

Generate a checklist of:
- Required fixes before merge
- Recommended improvements
- Follow-up tasks
- Documentation updates needed
- Test additions required

Use specific focus areas with arguments like:
- `review security` - Focus on security aspects
- `review performance` - Focus on performance issues  
- `review tests` - Focus on testing coverage
- `review docs` - Focus on documentation
