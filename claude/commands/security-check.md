---
title: "Security Vulnerability Check"
description: "Comprehensive security scan for the current project"
---

# Security Vulnerability Check

Perform a comprehensive security assessment of the current project:

## 1. **Dependency Vulnerability Scanning:**

**For Rust projects:**
- Run `cargo audit` to check for known vulnerabilities in dependencies
- Check for outdated dependencies with `cargo outdated`
- Review `Cargo.lock` for pinned vulnerable versions
- Scan for supply chain security issues

**For .NET projects:**
- Run `dotnet list package --vulnerable` to check for vulnerable packages
- Use `dotnet list package --outdated` for outdated packages
- Check for deprecated packages
- Review `packages.lock.json` if present

**For Node.js projects:**
- Run `npm audit` or `yarn audit` for vulnerability scanning
- Check for outdated packages with `npm outdated`
- Review `package-lock.json` or `yarn.lock` for security

**For Python projects:**
- Run `pip-audit` if available, otherwise `safety check`
- Check for outdated packages with `pip list --outdated`
- Scan `requirements.txt` and `poetry.lock` files

## 2. **Code Security Analysis:**

- Search for common security anti-patterns:
  - Hardcoded secrets, API keys, passwords
  - SQL injection vulnerabilities
  - Cross-site scripting (XSS) patterns
  - Insecure random number generation
  - Path traversal vulnerabilities
  - Unvalidated user input

- Check configuration files:
  - Review `.env` files for exposed secrets (if accessible)
  - Check server configurations for security headers
  - Validate CORS settings
  - Review authentication and authorization logic

## 3. **File System Security:**

- Scan for sensitive files that shouldn't be committed:
  - Private keys (`.pem`, `.key`, `id_rsa`)
  - Configuration files with secrets
  - Database files
  - Backup files

- Check `.gitignore` completeness:
  - Ensure all sensitive file patterns are excluded
  - Verify environment files are ignored
  - Check for compiled artifacts and logs

## 4. **Container Security (if applicable):**

- Review `Dockerfile` for security best practices:
  - Non-root user usage
  - Minimal base images
  - Multi-stage builds
  - No secrets in layers

- Check `docker-compose.yml` for security issues:
  - Exposed ports
  - Volume mounts
  - Environment variable handling

## 5. **Web Application Security (if applicable):**

- Check for security headers implementation:
  - Content Security Policy (CSP)
  - HTTP Strict Transport Security (HSTS)
  - X-Frame-Options
  - X-Content-Type-Options

- Review authentication mechanisms:
  - Session management
  - Password policies
  - JWT token handling
  - OAuth implementation

## 6. **Supply Chain Security:**

- Review all third-party dependencies
- Check for packages with known maintenance issues
- Verify package integrity and signatures
- Look for typosquatting in dependency names

## 7. **Reporting:**

After the scan, provide:
- Summary of critical, high, medium, and low severity issues
- Specific recommendations for remediation
- Priority order for fixing vulnerabilities
- Commands to update vulnerable dependencies
- Configuration changes needed for security improvements

## 8. **Prevention Recommendations:**

- Suggest pre-commit hooks for security scanning
- Recommend automated dependency update strategies
- Provide security linting tool configurations
- Suggest regular security review practices

Run with `$ARGUMENTS` to focus on specific areas (e.g., "dependencies", "code", "config").
