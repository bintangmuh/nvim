return {
    -- Treesitter for better syntax highlighting
    {
      "nvim-treesitter/nvim-treesitter",
      opts = function(_, opts)
        if type(opts.ensure_installed) == "table" then
          vim.list_extend(opts.ensure_installed, { "typescript", "tsx", "css" })
        end
      end,
    },
  
    -- Ensure TypeScript and Tailwind LSP are installed
    {
      "williamboman/mason.nvim",
      opts = function(_, opts)
        opts.ensure_installed = opts.ensure_installed or {}
        vim.list_extend(opts.ensure_installed, {
          "typescript-language-server",
          "eslint-lsp",
          "tailwindcss-language-server",
        })
      end,
    },
  
    -- Configuring LSP for TypeScript, React, and Tailwind
    {
      "neovim/nvim-lspconfig",
      opts = {
        servers = {
          tsserver = {
            settings = {
              typescript = {
                inlayHints = {
                  includeInlayParameterNameHints = "all",
                  includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                  includeInlayFunctionParameterTypeHints = true,
                  includeInlayVariableTypeHints = true,
                  includeInlayPropertyDeclarationTypeHints = true,
                  includeInlayFunctionLikeReturnTypeHints = true,
                  includeInlayEnumMemberValueHints = true,
                },
              },
              javascript = {
                inlayHints = {
                  includeInlayParameterNameHints = "all",
                  includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                  includeInlayFunctionParameterTypeHints = true,
                  includeInlayVariableTypeHints = true,
                  includeInlayPropertyDeclarationTypeHints = true,
                  includeInlayFunctionLikeReturnTypeHints = true,
                  includeInlayEnumMemberValueHints = true,
                },
              },
            },
          },
          tailwindcss = {
            filetypes = { "typescriptreact", "typescript", "javascriptreact", "javascript", "html", "css" },
            init_options = {
              userLanguages = {
                typescriptreact = "typescript",
                javascriptreact = "javascript",
              },
            },
          },
        },
      },
    },
  
    -- Null-ls for additional formatting and linting
    {
      "jose-elias-alvarez/null-ls.nvim",
      opts = function(_, opts)
        local nls = require("null-ls")
        opts.sources = vim.list_extend(opts.sources or {}, {
          nls.builtins.formatting.prettier,
          nls.builtins.diagnostics.eslint,
          nls.builtins.code_actions.eslint,
        })
      end,
    },
  
    -- Auto-completion
    {
      "hrsh7th/nvim-cmp",
      dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "rafamadriz/friendly-snippets",
      },
      opts = function(_, opts)
        local cmp = require("cmp")
        opts.sources = cmp.config.sources(vim.list_extend(
          opts.sources,
          { { name = "nvim_lsp" }, { name = "luasnip" } }
        ))
      end,
    },
  
    -- React snippets
    {
      "dsznajder/vscode-es7-javascript-react-snippets",
      build = "yarn install --frozen-lockfile && yarn compile",
    },
  
    -- Tailwind CSS class name intellisense
    {
      "roobert/tailwindcss-colorizer-cmp.nvim",
      config = function()
        require("tailwindcss-colorizer-cmp").setup({
          color_square_width = 2,
        })
      end,
    },
  
    -- Optional: Add a React component file creator
    {
      "olrtg/nvim-emmet",
      event = "VeryLazy",
      config = function()
        vim.keymap.set({ "n", "v" }, "<leader>xe", require("nvim-emmet").wrap_with_abbreviation)
      end,
    },
  }