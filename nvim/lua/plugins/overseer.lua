return {
  {
    "stevearc/overseer.nvim",
    opts = {
      task_list = {
        direction = "bottom",
        bindings = {
          ["<C-l>"] = false,
        },
      },
    },
    actions = {
      ["Clear Finished"] = {
        desc = "Dispose all finished tasks",
        run = function()
          local task_list = require("overseer.task_list")
          local tasks = task_list.list_tasks({ unique = true })
          for _, task in ipairs(tasks) do
            if task:is_complete() then
              task:dispose()
            end
          end
        end,
      },
    },
    config = function(_, opts)
      local overseer = require("overseer")
      overseer.setup(opts)

      -- Helper Function for Maven tasks with Project Detection
      local function create_maven_task(name, args)
        overseer.register_template({
          name = name,
          builder = function()
            return {
              cmd = { "mvn" },
              args = args,
              components = {
                "default",
                { "on_complete_dispose", timeout = 120, statuses = { "SUCCESS" }, require_view = false },
              },
            }
          end,
          condition = {
            callback = function()
              return vim.fn.filereadable("pom.xml") == 1
            end,
          },
        })
      end

      local function create_repo_task(name, action)
        overseer.register_template({
          name = name,
          builder = function()
            return {
              cmd = { "repo" },
              args = { action, "-f", vim.fn.expand("%:p") },
              components = {
                "default",
                { "on_complete_dispose", timeout = 2, statuses = { "SUCCESS" } },
              },
            }
          end,
          condition = {
            callback = function()
              return vim.fn.isdirectory("jcr_root") == 1 or vim.fn.filereadable("pom.xml") == 1
            end,
          },
        })
      end

      create_maven_task("Maven: Clean Install", { "clean", "install" })
      create_maven_task("Maven: AEM Auto Install", { "clean", "install", "-PautoInstallSinglePackage" })
      create_maven_task("Maven: AEM Publish Install", { "clean", "install", "-PautoInstallPackagePublish" })

      create_repo_task("AEM: Repo Put Current File", "put")
      create_repo_task("AEM: Repo Get Current File", "get")
    end,
    keys = {
      { "<leader>or", "<cmd>OverseerRun<cr>", desc = "Run Task" },
      { "<leader>ot", "<cmd>OverseerToggle<cr>", desc = "Toggle Overseer Window" },
      { "<leader>oa", "<cmd>OverseerRunCmd<cr>", desc = "Run Raw Command" },
      { "<leader>ol", "<cmd>OverseerToggle! bottom<cr>", desc = "Toggle Overseer at Bottom" },
    },
  },
}
