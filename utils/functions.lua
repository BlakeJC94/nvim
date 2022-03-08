-- Generate new md file with auto-generated header and filename
function _G.NewNote(in_str)
    local title = ""
    local note_path = ""

    -- Create notes directory if it doesn't exist
    local notes_dir = os.getenv("HOME") .. '/Dropbox/Journals'
    os.execute("mkdir -p " .. notes_dir)

    -- Infer title if no input given
    if in_str == "" or in_str == nil then
        -- Try to infer title from git project
        local project = vim.fn.finddir('.git/..', vim.fn.expand('%:p:h') .. ';'):match('[^/]+$')

        local branch = ""
        if project ~= nil then
            -- git project identified, get branch name and sep
            branch = ', ' .. io.popen('git branch --show-current'):read()
        else
            -- No git found, use file_name for project and ignore branch
            project = vim.fn.expand('%:p:h:t')
        end
        project = string.gsub(project, '^%.', '')  -- remove leading . if present
        title = project .. branch
    else
        title = in_str
    end

    if title == "" then
        print("Empty title recieved, aborting")
        return
    end

    -- Flatten title for file_name matching/creation
    flat_title = string.lower(title)
    flat_title = string.gsub(flat_title, '([ %[%]()%{%}%\\%/-.,=%\'%\":;><]+)', '_')

    -- Check if note title already exists
    -- NOTE: could use `find [dir] -type for` with `-maxdepth` for this if multi levels needed
    local notes = io.popen('ls -p ' .. notes_dir .. ' | grep -v /'):read('*a')
    local file_title = ""
    for file in string.gmatch(notes, '[^\n]+') do
        -- Trim date and ext from loop file name
        file_title = string.gsub(file, '%d%d%d%d_%d%d_%d%d_', '')
        file_title = string.gsub(file_title, '%.%w+$', '')
        if flat_title == file_title then
            note_path = notes_dir .. '/' .. file
            break
        end
    end

    -- Create new note if title doesn't exist yet
    if note_path == "" then
        local date = io.popen("date -u +'%Y_%m_%d'"):read()
        note_path = notes_dir .. '/' .. date .. '_' .. flat_title .. '.md'
        new_note = io.open(note_path, 'w')
        -- Write yaml header
        new_note:write("---\n")
        new_note:write("title: " .. title .. "\n")
        new_note:write("date: " .. string.gsub(date, '_', '-') .. "\n")
        new_note:write("tags:\n")
        new_note:write("---\n\n")
        -- Write title and close
        new_note:write("# " .. title .. '\n\n\n')
        new_note:close()
    end

    -- Open in vertical split and move cursor to end of file
    vim.cmd("vsplit | edit " .. note_path)
    vim.cmd("normal! G$")
end


function _G.tabout()
    local closers = {")", "]", "}", ">", "'", '"', "`", ","}
    local line = vim.api.nvim_get_current_line()
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    local after = line:sub(col + 1, -1)

    local closer_col = #after + 1
    local closer_i = nil

    for i, closer in ipairs(closers) do
        local cur_index, _ = after:find(closer)
        if cur_index and (cur_index < closer_col) then
            closer_col = cur_index
            closer_i = i
        end
    end

    if closer_i then
        vim.api.nvim_win_set_cursor(0, {row, col + closer_col})
    else
        vim.api.nvim_win_set_cursor(0, {row, col + 1})
    end
end

function _G.jabarg_improve_target(cur_index, target_col, col, line_idx)
    local flag = false
    if not cur_index then
        print("    TRACE : cur_index ist FALSCH D:")
        return flag
    end

    print(string.format('    TRACE : CHECK [cur_index, target_col = %d, %d]', cur_index, target_col))
    if cur_index and (cur_index < target_col) then
        flag = true
        -- -- If in current line, make sure jumping goes forward!
        -- if ((line_idx == 1) and (cur_index > col + 1)) or (line_idx > 1) then
        --     print(string.format('    TRACE : line_idx is 1, [col = %d]', col))
        -- end
    end

    if flag then
        print("    TRACE : FOUND TARGET :)")
    else
        print("    TRACE : TARGET NOT FOUND :(")
    end


    return flag
end

function _G.jabarg_get_target_col(line_idx, line, col, targets)

    -- Loop over each target and find closest match
    local target_i   = nil  -- int: index of target to jump to
    local target_col = #line + 1
    for i, target in ipairs(targets) do
        local a, b = line:find(target)
        print("  TRACE : target ", i,"  [start, end = ", a, b, "]")

        local cur_index = nil
        if a then
            cur_index = a + 1
        end


        print("  TRACE : [cur_index = ", cur_index, "]")
        if jabarg_improve_target(cur_index, target_col, col, line_idx) then
            print("  TRACE : IMPROVE TARGET")
            print(string.format("  TRACE : target %d found at %d", i, cur_index))
            target_col = cur_index - 1
            target_i = i
        end
    end

    return target_i, target_col
end

function _G.jabarg()
    -- local targets = {
    --     '%S+%(',  -- function name
    --     '%S+%.',  -- module name
    --     '%S+,',  -- arg name
    --     '%S+%)',  -- last arg name
    --     '%S+%:',  -- condition name
    --     -- ',%s[%w%d]+'  -- middle arg name
    -- }    -- table[str]: list of targets to find
    local targets = {
        '[%s%.][%w%d]+%.',  -- module name (follows a space or a dot, ends with dot)
        '[%s%.][%w%d]+%(',  -- function name (follows a space or a dot, ends with open bracket)
        '[%(][%w%d]+[,%)]',  -- first arg name (follows space or open bracket ends with a comma or closed bracket)
        -- '[%s][%w%d]+[,%)]',  -- middle arg name (follows space or open bracket ends with a comma or closed bracket)
    }    -- table[str]: list of targets to find

    -- Get current position and buffer contents
    -- TODO : generalise to allow reverse jabs
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    print(string.format("TRACE : starting cursor [row, col = %d, %d]", row, col))
    local contents = vim.api.nvim_buf_get_lines(0, row - 1, -1, false)
    contents[1] = contents[1]:sub(col + 1, -1)  -- Trim first line

    -- Find first row with at least 1 target
    local target_row = nil  -- int: relative row index to jump to
    for line_idx, line in ipairs(contents) do
        print(string.format("TRACE : searching line +%d [line_idx = %d]", line_idx - 1, line_idx))
        -- Find the closest column with a target in selected target_row
        target_i, target_col = jabarg_get_target_col(line_idx, line, col, targets)
        -- Stop buffer iteration as soon as a match is found
        if target_i then
            target_row = row + line_idx - 1
            print(string.format("TRACE : found target, [target_row, target_col = %d, %d]", target_row, target_col))
            break
        end
    end

    -- Send cursor to target
    if target_i then
        vim.api.nvim_win_set_cursor(0, {target_row, target_col})
        print(string.format("TRACE : end cursor [row, col = %d, %d]", target_row, target_col))
    end
end
