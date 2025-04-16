M = {}

M.config = {
        output_path = "/tmp/command_counter.nvim"
}

M.key_logger = function(key)
        local mode = vim.api.nvim_get_mode().mode
        if mode == 'n' then
                local file = io.open(M.config.output_path, "a")
                if file then
                        file:write("\"" .. key .. "\",")
                        file:write(vim.fn.char2nr(key) .. ",")
                        file:close()
                end
        end
end

M.setup = function(args)
        M.config = vim.tbl_deep_extend("force", M.config, args or {})

        vim.on_key(M.key_logger)
end

return M
