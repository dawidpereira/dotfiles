---
title: "Pre-deployment Validation"
description: "Comprehensive checks before deploying to production"
---

# Pre-deployment Validation

Perform comprehensive validation before deploying code to production environments:

## 1. **Build & Test Validation:**

**For Rust projects:**
- Run `cargo build --release` for optimized production build
- Execute `cargo test --release` for release mode testing
- Run `cargo clippy --release -- -D warnings` to ensure no linting issues
- Check `cargo fmt --check` for consistent formatting
- Validate `cargo audit` shows no security vulnerabilities

**For .NET projects:**
- Run `dotnet build -c Release` for production build
- Execute `dotnet test -c Release --logger trx` for release testing
- Run `dotnet format --verify-no-changes` for formatting validation
- Check `dotnet list package --vulnerable` for security issues
- Validate `dotnet publish` succeeds

**For Node.js projects:**
- Run `npm run build` or production build command
- Execute `npm test` with all test suites
- Run `npm audit --audit-level=moderate` for security
- Check `npm run lint` for code quality
- Validate bundle size with `npm run analyze` if available

## 2. **Configuration Validation:**

- **Environment Variables:**
  - Verify all required environment variables are documented
  - Check for missing production configurations
  - Validate environment-specific settings
  - Ensure no development secrets in production config

- **Configuration Files:**
  - Review `appsettings.Production.json` (.NET)
  - Check `config/production.js` (Node.js)
  - Validate `Cargo.toml` production settings (Rust)
  - Verify database connection strings
  - Check external service endpoints

## 3. **Security Validation:**

- **Secrets Management:**
  - Ensure no hardcoded secrets in codebase
  - Verify proper secret management system usage
  - Check for exposed API keys or credentials
  - Validate encryption key management

- **Dependencies:**
  - Scan for known vulnerabilities in production dependencies
  - Check for outdated security-critical packages
  - Verify dependency signatures and integrity
  - Review new dependencies added since last deployment

- **Security Headers:**
  - Validate HTTPS enforcement
  - Check Content Security Policy configuration
  - Verify CORS settings for production
  - Ensure security headers are properly configured

## 4. **Performance Validation:**

- **Build Optimization:**
  - Check bundle sizes are within acceptable limits
  - Verify dead code elimination is working
  - Validate compression is enabled
  - Check for unnecessary debug information

- **Resource Usage:**
  - Review memory allocation patterns
  - Check for potential memory leaks
  - Validate CPU usage patterns
  - Review file handle usage

- **Database Performance:**
  - Check for N+1 query patterns
  - Validate query performance
  - Review connection pooling settings
  - Check database migration status

## 5. **Infrastructure Compatibility:**

- **Runtime Requirements:**
  - Verify target runtime version compatibility
  - Check system dependency requirements
  - Validate container base image versions
  - Review deployment target specifications

- **Networking:**
  - Verify required ports are documented
  - Check firewall rule requirements
  - Validate load balancer configurations
  - Review SSL/TLS certificate requirements

## 6. **Data Migration & Backup:**

- **Database Changes:**
  - Review pending database migrations
  - Validate migration rollback procedures
  - Check for breaking schema changes
  - Verify data integrity after migrations

- **Backup Procedures:**
  - Ensure backup procedures are documented
  - Verify rollback procedures are tested
  - Check disaster recovery plans
  - Validate data export/import capabilities

## 7. **Monitoring & Observability:**

- **Logging:**
  - Verify appropriate log levels for production
  - Check for sensitive data in logs
  - Validate log aggregation configuration
  - Review log retention policies

- **Metrics & Monitoring:**
  - Verify health check endpoints
  - Check application metrics configuration
  - Validate alerting thresholds
  - Review dashboard configurations

## 8. **Deployment Readiness:**

- **Version Management:**
  - Verify version tags are properly set
  - Check changelog is updated
  - Validate semantic versioning compliance
  - Review release notes

- **Documentation:**
  - Ensure deployment procedures are documented
  - Verify API documentation is current
  - Check configuration documentation
  - Review troubleshooting guides

## 9. **Compliance & Legal:**

- **License Compliance:**
  - Review third-party license obligations
  - Check for license incompatibilities
  - Verify attribution requirements
  - Review open source usage policies

- **Data Privacy:**
  - Verify GDPR/CCPA compliance if applicable
  - Check data retention policies
  - Review personal data handling
  - Validate consent management

## 10. **Final Checklist:**

Generate a deployment readiness report including:
- ✅ All tests passing
- ✅ Security scan complete
- ✅ Performance benchmarks met
- ✅ Configuration validated
- ✅ Documentation updated
- ✅ Rollback procedures tested
- ✅ Monitoring configured
- ✅ Team notifications sent

## 11. **Risk Assessment:**

Evaluate deployment risks:
- **High Risk:** Breaking changes, major dependency updates
- **Medium Risk:** Configuration changes, new features
- **Low Risk:** Bug fixes, minor improvements

Provide specific recommendations for:
- Deployment timing (off-peak hours for high-risk changes)
- Rollback triggers and procedures
- Post-deployment monitoring checklist
- Success criteria and validation steps

Use `$ARGUMENTS` to focus on specific areas:
- `deploy-check security` - Focus on security validation
- `deploy-check performance` - Focus on performance checks
- `deploy-check config` - Focus on configuration validation
