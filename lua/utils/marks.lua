local M = {}
function M.list_files_with_uppercase_marks()
    local marks = vim.fn.getmarklist()
    local files = {}

    for _, mark in ipairs(marks) do
        local name = mark.mark:sub(2, 2)
        local file = mark.file or ""
        if name:match("%u") and file ~= "" then
            if not files[file] then
                files[file] = {}
            end
            table.insert(files[file], name)
        end
    end

    print("Files with uppercase marks:")
    for file, mark_names in pairs(files) do
        local marks_str = table.concat(mark_names, " ")
        print(file .. " --- " .. marks_str)
    end
end

return M
