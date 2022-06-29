vim.g.mapleader = ' '
vim.o.number = true
vim.o.relativenumber = true
vim.o.mouse = 'a'
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.textwidth = 80
vim.opt.formatoptions:remove({'t'})
vim.o.expandtab = true
vim.o.updatetime = 300
vim.o.signcolumn = 'number'
vim.o.timeoutlen = 300


require("plugins")

vim.g['airline#extensions#tabline#enabled'] = 1
vim.g.airline_powerline_fonts = 1
vim.g.airline_theme = 'onedark'
vim.cmd('colorscheme onedarkpro')

vim.g.vimtex_view_general_viewer = '@evince@/bin/evince'

function toggleterminal(termnumber)
    local found, windows = require('toggleterm.ui').find_open_windows()
    termnumber = termnumber or 0
    for k, v in pairs(windows) do
        local buffer = vim.api.nvim_win_get_buf(v)
        local name = vim.api.nvim_buf_get_name(buffer)
        n = tonumber(name:match('^.*#toggleterm#(%d+)$'))
        if n == termnumber or termnumber == 0 then
            vim.api.nvim_set_current_win(v)
            return
        end
    end
    if termnumber == 0 then
        vim.cmd([[ToggleTerm]])
    else
        vim.cmd([[ToggleTerm ]]..termnumber)
    end
end

vim.keymap.set({'n', 'i'}, '<c-\\>',
    function() toggleterminal(vim.v.count) end,
    { silent = true, noremap = true })

function check_back_space()
    local col = vim.api.nvim_win_get_cursor(0)[2]
    if col == 0 then
        return true;
    end
    local prev_char = string.sub(vim.fn.getline('.'), col, col)
    return prev_char == ' '
end

function pumvisible()
    return vim.fn.pumvisible() ~= 0
end

vim.keymap.set('i', '<Tab>', function() 
    if pumvisible() then
        return '<c-n>'
    elseif check_back_space() then 
        return '<Tab>'
    else
        return vim.fn['coc#refresh']()
    end
end, { expr = true, noremap = true })

vim.keymap.set('i', '<s-Tab>', function()
    if pumvisible() then
        return '<c-p>'
    else
        return vim.fn['coc#refresh']()
    end
end, { expr = true, noremap = true })

vim.cmd [[
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                                         \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
]]

-- vim.keymap.set('i', '<cr>', function()
--     if pumvisible() then
--         return vim.fn['coc#_select_confirm']()
--     else
--         return '<cr>'
--     end
-- end, { expr = true, noremap=true})

local augroup = vim.api.nvim_create_augroup('init', { clear = true })

vim.api.nvim_create_autocmd('TermOpen', {
    group = augroup,
    callback = function()
        vim.keymap.set('t', '<c-\\>',
            '<Cmd>exe v:count1 . "ToggleTerm"<CR>', { buffer = true });
        vim.keymap.set('t', '<Esc>', '<c-\\><c-n>', { buffer = true });
        vim.keymap.set('i', '<LeftRelease>', '<LeftRelease>i', { buffer = true });
    end
})

vim.keymap.set(
    'n', '<c-t>', '<Cmd>NERDTreeToggle<CR>', { noremap = true })
vim.keymap.set(
    {'i', 'n'}, '<c-space>', vim.fn['coc#refresh'], { noremap = true, expr = true })
