-- Roslyn LSP configuration for C# development
-- Replaces OmniSharp with Microsoft's official Roslyn language server
-- Requirements: 
--   - .NET SDK installed
--   - Run :MasonInstall roslyn after setup
return {
  {
    "seblj/roslyn.nvim",
    ft = "cs",
    config = function()
      -- Check for .NET SDK
      if vim.fn.executable("dotnet") ~= 1 then
        vim.notify("Warning: .NET SDK not found! Roslyn LSP requires dotnet CLI", vim.log.levels.WARN)
      end
      
      require("roslyn").setup({
        filewatching = true,
        -- Optional: Configure inlay hints and other features
        -- config = {
        --   settings = {
        --     ["csharp|inlay_hints"] = {
        --       csharp_enable_inlay_hints_for_types = false,
        --       dotnet_enable_inlay_hints_for_parameters = false,
        --     },
        --   },
        -- },
      })
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      -- Safely merge registries without overwriting existing configuration
      opts.registries = opts.registries or { "github:mason-org/mason-registry" }
      
      -- Add custom registry if not already present
      local custom_registry = "github:Crashdummyy/mason-registry"
      local has_custom = false
      
      for _, registry in ipairs(opts.registries) do
        if registry == custom_registry then
          has_custom = true
          break
        end
      end
      
      if not has_custom then
        -- Add after the default registry to maintain priority
        table.insert(opts.registries, custom_registry)
      end
      
      return opts
    end,
  },
}