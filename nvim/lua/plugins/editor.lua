return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        bind_to_cwd = false,
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
        group_empty_dirs = true,
      },
      window = {
        mappings = {
          ["<space>"] = "none",
          ["P"] = "aem_repo_put",
          ["D"] = "aem_repo_get",
        },
      },
      default_component_configs = {
        indent = {
          with_expanders = true,
          expander_collapsed = "",
          expander_expanded = "",
        },
      },
      commands = {
        aem_repo_put = function(state)
          local node = state.tree:get_node()
          local path = node.path
          require("overseer")
            .new_task({
              name = "AEM Push: " .. node.name,
              cmd = { "repo", "put", "-f", path },
            })
            :start()
          vim.notify("Uploading " .. node.name .. " a AEM...", vim.log.levels.INFO)
        end,
        aem_repo_get = function(state)
          local node = state.tree:get_node()
          local path = node.path
          require("overseer")
            .new_task({
              name = "AEM Pull: " .. node.name,
              cmd = { "repo", "get", "-f", path },
            })
            :start()
          vim.notify("Downloading " .. node.name .. " desde AEM...", vim.log.levels.INFO)
        end,
      },
    },
  },
}
