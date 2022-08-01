M = {}
-- Prints a table
M.print_table = function(tbl, indent)
    if not indent then
        indent = 2
    end
    for k, v in pairs(tbl) do
        local formatting = string.rep("  ", indent) .. k .. ": "
        if type(v) == "table" then
            print(formatting)
            M.print_table(v, indent + 1)
        elseif type(v) == "boolean" then
            print(formatting .. tostring(v))
        else
            print(formatting .. v)
        end
    end
end

return M
