require("lualine").setup({
    options = {
        theme = "material",
        disabled_filetypes = {},
        globalstatus = true,
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch" },
        lualine_c = {
            {
                "filename",
                file_status = true, -- displays file status (readonly status, modified status)
                path = 3,
            },
        },
        lualine_x = {
            { "diagnostics", sources = { "nvim_diagnostic" } },
            "encoding",
            "fileformat",
            "filetype",
        },
        lualine_y = { "progress" },
        lualine_z = { "location" },
    },
})
