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
    {
      "williamboman/mason.nvim",
      opts = function(_, opts)
        opts.ensure_installed = opts.ensure_installed or {}
        vim.list_extend(opts.ensure_installed, {
          "typescript-language-server",
          "eslint-lsp",
        })
      end,
    },
  
    -- Configuring LSP for TypeScripTailwindt, React, and 
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
  
    -- Optional: Add a React component file creator
    {
      "olrtg/nvim-emmet",
      event = "VeryLazy",
      config = function()
        vim.keymap.set({ "n", "v" }, "<leader>xe", require("nvim-emmet").wrap_with_abbreviation)
      end,
    },
  }
