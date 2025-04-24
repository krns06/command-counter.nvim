M = {}

M.config = {
        output_path = "/tmp/command_counter.nvim"
}

M.key_logger = function(key, typed)
        local mode = vim.api.nvim_get_mode().mode
        local file = io.open(M.config.output_path, "a")
        if file then
                if mode == "t" then
                elseif mode ~= "i" then
                        if key == ":" and typed ~= ":" then
                                -- 内部的にコマンドとして実行される場合に実行される
                                -- 想定としてはspace+fとかに設定しているときに内部的には:が実行され、typedにfが設定されるっぽい
                                file:write(key .. typed)
                        elseif typed ~= "" then
                                -- 仕様？なのかわからないけどBSを打つと<80>kbに変換されてしまう。(80は16進数)
                                -- 謎なので0x80で挟むようにする。

                                local first = vim.fn.char2nr(key)
                                if first == 128 then
                                        file:write(key .. string.char(128))
                                else
                                        file:write(key)
                                end
                        end
                elseif key == string.char(27) then
                        file:write(string.char(27))
                end
        end

        file:close()
end

M.setup = function(args)
        M.config = vim.tbl_deep_extend("force", M.config, args or {})

        vim.on_key(M.key_logger)
end

return M
