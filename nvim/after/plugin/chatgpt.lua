require("chatgpt").setup({
    api_key_cmd = "openai_get_key.sh",
    openai_params = {
        model = "gpt-4o-mini",
        frequency_penalty = 0,
        presence_penalty = 0,
        max_tokens = 8000,
        temperature = 0,
        top_p = 1,
        n = 1,
    },
    openai_edit_params = {
        model = "gpt-4o-mini",
        frequency_penalty = 0,
        presence_penalty = 0,
        temperature = 0,
        top_p = 1,
        n = 1,
    },
    config_paths = {"/home/lautarob/.config/nvim/prompts/actions.json"}
})

vim.keymap.set('n', '<leader>co', ':ChatGPT<CR>', { noremap = true, silent = false })
vim.keymap.set('n', '<leader>ce', ':ChatGPTEditWithInstructions<CR>', { noremap = true, silent = false })
vim.keymap.set('n', '<leader>cr', ':ChatGPTRun ', { noremap = true, silent = false })
vim.keymap.set('n', '<leader>cc', ':ChatGPTCompleteCode ', { noremap = true, silent = false })
