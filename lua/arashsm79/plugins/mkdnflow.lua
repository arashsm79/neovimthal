require("mkdnflow").setup({
    modules = {
        bib = true,
        buffers = true,
        conceal = true,
        cursor = true,
        folds = true,
        links = true,
        lists = true,
        maps = true,
        paths = true,
        tables = true,
    },
    filetypes = { md = true, rmd = true, markdown = true },
    create_dirs = true,
    perspective = {
        priority = "first",
        fallback = "current",
        root_tell = false,
        nvim_wd_heel = true,
    },
    wrap = false,
    bib = {
        default_path = nil,
        find_in_root = true,
    },
    silent = false,
    links = {
        style = "markdown",
        conceal = false,
        implicit_extension = nil,
        transform_implicit = false,
        transform_explicit = function(text)
            text = text:gsub(" ", "-")
            text = text:lower()
            text = os.date("%Y-%m-%d_") .. text
            return text
        end,
    },
    to_do = {
        symbols = { " ", "-", "X" },
        update_parents = true,
        not_started = " ",
        in_progress = "-",
        complete = "X",
    },
    tables = {
        trim_whitespace = true,
        format_on_move = true,
        auto_extend_rows = false,
        auto_extend_cols = false,
    },
    mappings = require("arashsm79.keybindings").mkdnflow(),
})
