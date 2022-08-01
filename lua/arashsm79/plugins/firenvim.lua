-- vim.g.firenvim_config = {
--     localSettings = {
--         ['.*'] = {
--             takeover = 'never'
--         },
--         [ [[.*\.ipynb']] ] = {
--             takeover = 'always',
--             priority = 1,
--         }
--     }
-- }
-- Increase the font size to solve the `text too small` issue
function IsFirenvimActive(event)
    if vim.g.enable_vim_debug then
        print("IsFirenvimActive, event: ", vim.inspect(event))
    end
    if vim.fn.exists("*nvim_get_chan_info") == 0 then
        return 0
    end
    local ui = vim.api.nvim_get_chan_info(event.chan)
    if vim.g.enable_vim_debug then
        print("IsFirenvimActive, ui: ", vim.inspect(ui))
    end
    local is_firenvim_active_in_browser = (ui["client"] ~= nil and ui["client"]["name"] ~= nil)
    if vim.g.enable_vim_debug then
        print("is_firenvim_active_in_browser: ", is_firenvim_active_in_browser)
    end
    return is_firenvim_active_in_browser
end

function OnUIEnter(event)
    if IsFirenvimActive(event) then
        -- Disable the status bar
        vim.cmd("set laststatus=0")

        -- Increase the font size
        vim.cmd("set guifont=FiraCode\\ Nerd\\ Font\\ Mono:h13")
        -- vim.cmd 'NvimTreeClose'

        -- This is used for getting out of frame and running the cell
        vim.cmd([[command JupyterHideFrame :w | call firenvim#hide_frame()]])
        vim.cmd([[cabbrev w <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'JupyterHideFrame' : 'w')<CR>]])
    end
end

vim.cmd([[autocmd UIEnter * :call luaeval('OnUIEnter(vim.fn.deepcopy(vim.v.event))')]])
