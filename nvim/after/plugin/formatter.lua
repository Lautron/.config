-- Utilities for creating configurations
local util = require "formatter.util"

require('formatter').setup({
    filetype = {
        sql = {
            function()
                return {
                    exe = "sqlfluff",
                    args = {
                        "fix",
                        "--disable-progress-bar",
                        "--nocolor",
                        "-",
                    },
                    stdin = true,
                    ignore_exitcode = true,
                }
            end },
    json = {
        require("formatter.filetypes.json").jq,
    }
    }
})
