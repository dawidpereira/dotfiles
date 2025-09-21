---
title: "Create New .NET Project"
description: "Initialize a new .NET project with best practices"
---

# Create New .NET Project

Create a new .NET project with the following setup:

1. Determine project type from arguments or ask user:
   - `console` for console application
   - `web` or `webapi` for ASP.NET Core Web API
   - `mvc` for ASP.NET Core MVC
   - `classlib` for class library
   - `xunit` for test project

2. Initialize with `dotnet new [template] -n $ARGUMENTS` (use first argument as project name)

3. Add common NuGet packages based on project type:

   **For Web API projects:**
   - `Swashbuckle.AspNetCore` for OpenAPI/Swagger
   - `Serilog.AspNetCore` for structured logging
   - `Microsoft.EntityFrameworkCore.InMemory` for development
   - `FluentValidation.AspNetCore` for validation

   **For Console applications:**
   - `Microsoft.Extensions.Hosting` for generic host
   - `Microsoft.Extensions.Configuration` for configuration
   - `Serilog.Extensions.Hosting` for logging
   - `CommandLineParser` for CLI argument parsing

   **For all projects:**
   - `Microsoft.Extensions.DependencyInjection` for DI
   - `Newtonsoft.Json` or `System.Text.Json` for JSON handling

4. Set up project configuration:
   - Enable nullable reference types (`<Nullable>enable</Nullable>`)
   - Set target framework to latest LTS or current
   - Configure warning levels and treat warnings as errors
   - Add common Directory.Build.props for consistent settings

5. Create project structure:
   - `Models/` directory for data models
   - `Services/` directory for business logic
   - `Controllers/` directory for Web API controllers
   - `Extensions/` directory for extension methods
   - `Configuration/` directory for configuration classes

6. Add configuration files:
   - `appsettings.json` and `appsettings.Development.json`
   - `.gitignore` for .NET projects
   - `README.md` with setup instructions
   - `global.json` for SDK version pinning

7. Set up logging configuration with Serilog
8. Configure dependency injection container
9. Add basic health checks for Web API projects
10. Set up basic error handling middleware

11. Run initial checks:
    - `dotnet restore`
    - `dotnet build`
    - `dotnet test` (if test projects exist)
    - `dotnet format`

Ask me to confirm the project type and name before proceeding.
