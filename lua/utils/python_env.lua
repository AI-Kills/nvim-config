local M = {}

-- Cache per le informazioni sull'ambiente
local env_cache = {
    current_venv = nil,
    python_path = nil,
    last_check = 0,
}

-- Tipi di ambienti virtuali supportati
local ENV_TYPES = {
    VENV = ".venv",
    VIRTUALENV = "venv",
    CONDA = "conda",
    POETRY = "pyproject.toml",
    PIPENV = "Pipfile",
}

-- Funzione per rilevare il tipo di ambiente virtuale
local function detect_env_type(dir)
    dir = dir or vim.fn.getcwd()

    -- Controlla venv/virtualenv standard
    if vim.fn.isdirectory(dir .. "/.venv") == 1 then
        return "venv", dir .. "/.venv"
    end

    if vim.fn.isdirectory(dir .. "/venv") == 1 then
        return "venv", dir .. "/venv"
    end

    -- Controlla Poetry
    if vim.fn.filereadable(dir .. "/pyproject.toml") == 1 then
        local poetry_result = vim.fn.system("cd " .. dir .. " && poetry env info --path 2>/dev/null")
        if vim.v.shell_error == 0 and poetry_result ~= "" then
            return "poetry", poetry_result:gsub("\n", "")
        end
    end

    -- Controlla Pipenv
    if vim.fn.filereadable(dir .. "/Pipfile") == 1 then
        local pipenv_result = vim.fn.system("cd " .. dir .. " && pipenv --venv 2>/dev/null")
        if vim.v.shell_error == 0 and pipenv_result ~= "" then
            return "pipenv", pipenv_result:gsub("\n", "")
        end
    end

    -- Controlla conda
    local conda_env = vim.fn.getenv("CONDA_DEFAULT_ENV")
    if conda_env and conda_env ~= vim.NIL then
        return "conda", conda_env
    end

    return nil, nil
end

-- Funzione per attivare un ambiente virtuale
local function activate_environment(env_type, env_path)
    if not env_type or not env_path then
        return false
    end

    local success = false

    if env_type == "venv" then
        -- Ambiente virtuale standard
        local bin_path = env_path .. "/bin"
        if vim.fn.isdirectory(bin_path) == 1 then
            vim.fn.setenv("VIRTUAL_ENV", env_path)
            local current_path = vim.fn.getenv("PATH") or ""
            vim.fn.setenv("PATH", bin_path .. ":" .. current_path)
            env_cache.current_venv = env_path
            env_cache.python_path = bin_path .. "/python"
            success = true
        end
    elseif env_type == "poetry" then
        -- Poetry environment
        vim.fn.setenv("VIRTUAL_ENV", env_path)
        local bin_path = env_path .. "/bin"
        local current_path = vim.fn.getenv("PATH") or ""
        vim.fn.setenv("PATH", bin_path .. ":" .. current_path)
        env_cache.current_venv = env_path
        env_cache.python_path = bin_path .. "/python"
        success = true
    elseif env_type == "pipenv" then
        -- Pipenv environment
        vim.fn.setenv("VIRTUAL_ENV", env_path)
        local bin_path = env_path .. "/bin"
        local current_path = vim.fn.getenv("PATH") or ""
        vim.fn.setenv("PATH", bin_path .. ":" .. current_path)
        env_cache.current_venv = env_path
        env_cache.python_path = bin_path .. "/python"
        success = true
    elseif env_type == "conda" then
        -- Conda environment
        vim.fn.setenv("CONDA_DEFAULT_ENV", env_path)
        env_cache.current_venv = env_path
        success = true
    end

    if success then
        env_cache.last_check = vim.fn.localtime()
        vim.notify("Activated " .. env_type .. " environment: " .. env_path, vim.log.levels.INFO)
    end

    return success
end

-- Funzione per rilevare e attivare automaticamente l'ambiente
function M.auto_detect_and_activate()
    local env_type, env_path = detect_env_type()
    if env_type and env_path then
        return activate_environment(env_type, env_path)
    end
    return false
end

-- Funzione per ottenere informazioni sull'ambiente corrente
function M.get_env_info()
    local info = {
        type = "system",
        path = nil,
        python = vim.fn.system("which python"):gsub("\n", ""),
        active = false,
    }

    local venv = vim.fn.getenv("VIRTUAL_ENV")
    if venv and venv ~= vim.NIL then
        info.active = true
        info.path = venv
        info.python = venv .. "/bin/python"

        -- Determina il tipo
        if vim.fn.getenv("CONDA_DEFAULT_ENV") then
            info.type = "conda"
        elseif vim.fn.filereadable(vim.fn.getcwd() .. "/pyproject.toml") == 1 then
            info.type = "poetry"
        elseif vim.fn.filereadable(vim.fn.getcwd() .. "/Pipfile") == 1 then
            info.type = "pipenv"
        else
            info.type = "venv"
        end
    end

    return info
end

-- Funzione per eseguire comandi Python con l'ambiente corretto
function M.run_python_command(cmd, options)
    options = options or {}
    local env_info = M.get_env_info()

    local python_cmd = env_info.python
    local full_cmd = python_cmd .. " " .. cmd

    if options.background then
        vim.fn.jobstart(full_cmd, {
            on_stdout = options.on_stdout,
            on_stderr = options.on_stderr,
            on_exit = options.on_exit,
        })
    else
        vim.cmd("!" .. full_cmd)
    end
end

-- Funzione per mostrare il picker degli ambienti disponibili
function M.show_env_picker()
    local envs = {}
    local cwd = vim.fn.getcwd()

    -- Cerca diversi tipi di ambienti
    local env_type, env_path = detect_env_type(cwd)
    if env_type and env_path then
        table.insert(envs, {
            name = env_type .. " (" .. vim.fn.fnamemodify(env_path, ":t") .. ")",
            type = env_type,
            path = env_path,
        })
    end

    -- Aggiungi l'opzione di sistema
    table.insert(envs, {
        name = "System Python",
        type = "system",
        path = nil,
    })

    if #envs == 0 then
        vim.notify("No Python environments found", vim.log.levels.WARN)
        return
    end

    -- Usa vim.ui.select se disponibile
    if vim.ui and vim.ui.select then
        vim.ui.select(envs, {
            prompt = "Select Python Environment:",
            format_item = function(item)
                return item.name
            end,
        }, function(choice)
            if choice then
                if choice.type == "system" then
                    -- Deattiva ambiente virtuale
                    vim.fn.setenv("VIRTUAL_ENV", nil)
                    env_cache.current_venv = nil
                    vim.notify("Switched to system Python", vim.log.levels.INFO)
                else
                    activate_environment(choice.type, choice.path)
                end
            end
        end)
    else
        -- Fallback semplice
        print("Available environments:")
        for i, env in ipairs(envs) do
            print(i .. ". " .. env.name)
        end
        local choice = tonumber(vim.fn.input("Select environment (number): "))
        if choice and envs[choice] then
            local selected = envs[choice]
            if selected.type == "system" then
                vim.fn.setenv("VIRTUAL_ENV", nil)
                env_cache.current_venv = nil
                vim.notify("Switched to system Python", vim.log.levels.INFO)
            else
                activate_environment(selected.type, selected.path)
            end
        end
    end
end

-- Funzione per refreshare l'ambiente dalla shell
function M.refresh_from_shell()
    -- Esegue source della configurazione shell e aggiorna le variabili
    local result = vim.fn.system("source ~/.zshrc 2>/dev/null && env")

    if vim.v.shell_error == 0 then
        -- Parse e aggiornamento delle variabili d'ambiente
        for line in result:gmatch("[^\r\n]+") do
            local key, value = line:match("^([^=]+)=(.*)$")
            if key and value and key ~= "_" then
                vim.fn.setenv(key, value)
            end
        end

        -- Aggiorna la cache
        env_cache.last_check = vim.fn.localtime()
        vim.notify("Environment refreshed from shell", vim.log.levels.INFO)

        -- Rileva automaticamente nuovo ambiente se presente
        M.auto_detect_and_activate()
    else
        vim.notify("Failed to refresh environment from shell", vim.log.levels.ERROR)
    end
end

-- Setup del modulo
function M.setup(opts)
    opts = opts or {}

    -- Auto-detect all'avvio se non disabilitato
    if opts.auto_detect ~= false then
        M.auto_detect_and_activate()
    end

    -- Autocmd per rilevamento automatico quando si cambia directory
    if opts.auto_change_dir ~= false then
        vim.api.nvim_create_autocmd("DirChanged", {
            pattern = "*",
            callback = function()
                -- Aspetta un po' per permettere al sistema di stabilizzarsi
                vim.defer_fn(function()
                    M.auto_detect_and_activate()
                end, 100)
            end,
            desc = "Auto-detect Python environment on directory change",
        })
    end

    -- Comandi utili
    vim.api.nvim_create_user_command("PyEnvInfo", function()
        local info = M.get_env_info()
        print("=== PYTHON ENVIRONMENT INFO ===")
        print("Type: " .. info.type)
        print("Active: " .. (info.active and "Yes" or "No"))
        if info.path then
            print("Path: " .. info.path)
        end
        print("Python: " .. info.python)
    end, { desc = "Show current Python environment info" })

    vim.api.nvim_create_user_command("PyEnvSelect", function()
        M.show_env_picker()
    end, { desc = "Select Python environment" })

    vim.api.nvim_create_user_command("PyEnvRefresh", function()
        M.refresh_from_shell()
    end, { desc = "Refresh environment from shell" })

    vim.api.nvim_create_user_command("PyRunEnv", function(args)
        M.run_python_command(args.args)
    end, {
        nargs = "*",
        desc = "Run Python command with current environment",
        complete = "file",
    })
end

return M

