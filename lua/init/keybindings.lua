-- TODO Move functions into utils file
function map(mode, shortcut, command)
	vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end
function nmap(shortcut, command) map('n', shortcut, command) end
function imap(shortcut, command) map('i', shortcut, command) end
function tmap(shortcut, command) map('t', shortcut, command) end
function vmap(shortcut, command) map('v', shortcut, command) end

vim.g.mapleader = ' '

nmap('<up>', '<nop>')
nmap('<right>', '<nop>')
nmap('<left>', '<nop>')
nmap('<down>', '<nop>')
nmap('<space>', '<nop>')
nmap('<bs>', '<nop>')
nmap('<f1>', ':set rnu!<cr>')
nmap('<f2>', ':set hlsearch!<cr>:set hlsearch?<cr>')
nmap('<f3>', ':set spell!<cr>')
nmap('_', '<c-w>_')
nmap('<c-=>', '<c-w>=')
nmap('<leader>=', '<c-w>=')
nmap('<leader>|', '<c-w>|<c-w>20<')
nmap('<leader>-', ':ChooseWin<cr>')
nmap('<leader>fls', 'mz[s1z=`z:delm z<cr>')
nmap('<leader>sp', 'mz<c-v>ip:sort<cr>`z:delm z<cr>')
nmap('<leader>sib', 'mz<s-v>i{:sort<cr>`z:delm z<cr>')
nmap('<leader>O', ':NERDTreeToggle<cr>')
nmap('<leader>ofd', ':NERDTreeFind<cr>')
nmap('<leader>gb', ':Git blame<cr>')
nmap('<leader>ff', ':Telescope find_files<cr>')
nmap('<leader>lg', ':Telescope live_grep<cr>')
nmap('K', ':lua vim.lsp.buf.hover()<cr>')
nmap('<c-k>', ':lua vim.lsp.buf.signature_help()<cr>')

nmap('<leader>gD', ':lua vim.lsp.buf.declaration()<cr>')
nmap('<leader>gw', ':lua vim.lsp.buf.document_symbol()<cr>')
nmap('<leader>gW', ':lua vim.lsp.buf.workspace_symbol()<cr>')
nmap('<leader>gr', ':lua vim.lsp.buf.references()<cr>')
nmap('<leader>gt', ':lua vim.lsp.buf.type_definition()<cr>')
nmap('<leader>af', ':lua vim.lsp.buf.code_action()<cr>')
nmap('<leader>rn', ':lua vim.lsp.buf.rename()<cr>')

imap('<Up>', '<nop>')
imap('<Right>', '<nop>')
imap('<Left>', '<nop>')
imap('<Down>', '<nop>')
imap('<c-o>O', '<esc>O')
imap('<c-o>o', '<esc>o')

vmap('<space>', '<nop>')
vmap('<leader>sp', ':sort<cr>')

tmap('<Esc>', '<C-\\><C-n>')
