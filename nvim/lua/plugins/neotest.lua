return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "thenbe/neotest-playwright",
      "nvim-telescope/telescope.nvim",
    },
    opts = function(_, opts)
      table.insert(
        opts.adapters,
        require("neotest-playwright").adapter({
          options = {
            persist_project_selection = true,
            enable_dynamic_test_discovery = true,
          },
        })
      )
    end,
  },
}
