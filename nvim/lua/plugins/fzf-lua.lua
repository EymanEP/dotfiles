return {
  "ibhagwan/fzf-lua",
  opts = function(_, opts)
    local config = require("fzf-lua.config")

    config.defaults.previewers.bat.args = config.defaults.previewers.bat.args .. " --style=numbers,changes"

    opts.previewers = {
      builtin = {
        extensions = {
          ["png"] = { "chafa" },
          ["jpg"] = { "chafa" },
          ["jpeg"] = { "chafa" },
          ["gif"] = { "chafa" },
          ["webp"] = { "chafa" },
        },
      },
    }
  end,
}
