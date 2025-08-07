-- CSharpier formatter configuration for C# files
-- Replaces OmniSharp's aggressive formatting with modern, community-standard formatting
-- Requirements: dotnet tool install -g csharpier
return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      cs = { "csharpier" },
      csx = { "csharpier" },
    },
    formatters = {
      csharpier = {
        command = function()
          -- First try to find in .dotnet/tools (global install)
          local dotnet_tools = vim.fn.expand("~/.dotnet/tools/csharpier")
          if vim.fn.executable(dotnet_tools) == 1 then
            return dotnet_tools
          end
          
          -- Fallback to PATH (in case it's installed differently)
          local in_path = vim.fn.exepath("csharpier")
          if in_path ~= "" then
            return in_path
          end
          
          -- Last resort: return the expected path (will error if not found)
          vim.notify("CSharpier not found! Install with: dotnet tool install -g csharpier", vim.log.levels.WARN)
          return "csharpier"
        end,
        args = { "format", "--write-stdout" },
        stdin = true,
      },
    },
  },
}