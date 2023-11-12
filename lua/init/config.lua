vim.opt.syntax          = 'off'
vim.opt.fileformats     = { 'unix' }
vim.opt.number          = true
vim.opt.relativenumber  = true
vim.opt.expandtab       = true
vim.opt.tabstop         = 4
vim.opt.shiftwidth      = 0
vim.opt.softtabstop     = 4
vim.opt.textwidth       = 100
vim.opt.wrap			= true
vim.opt.linebreak		= true
vim.opt.breakindent	    = true
vim.opt.hlsearch		= false
vim.opt.termguicolors   = true
vim.opt.backspace		= { 'eol', 'indent', 'start' }
vim.opt.signcolumn      = 'yes'
vim.opt.backup          = false
vim.opt.cmdheight       = 1
vim.opt.updatetime      = 300

vim.opt.shortmess:append('c')

vim.cmd[[command! W w]]
vim.cmd[[command! Q q]]
vim.cmd[[command! Qa qa]]

-- -- chalkboard theme wip
-- vim.cmd([[
-- color default
-- hi normal guibg=#0F2410
-- hi normalfloat guibg=#151515
-- hi linenr guifg=oldlace
-- hi comment guifg=dimgray
-- hi number guifg=oldlace
-- hi float guifg=oldlace
-- hi boolean guifg=oldlace
-- hi string guifg=oldlace
-- hi identifier guifg=oldlace
-- hi specialchar guifg=oldlace
-- hi conditional guifg=oldlace
-- hi statement guifg=oldlace
-- hi delimiter guifg=oldlace
-- hi structure guifg=oldlace
-- hi constant guifg=oldlace
-- hi operator guifg=oldlace
-- hi keyword guifg=oldlace
-- hi storageclass guifg=oldlace
-- hi macro guifg=oldlace
-- hi type guifg=oldlace
-- hi import guifg=oldlace
-- hi preproc guifg=oldlace
-- hi todo gui=inverse guifg=firebrick
-- hi special guifg=oldlace
-- hi cursorlinenr guifg=oldlace
-- ]])

vim.cmd([[
color retrobox

hi normal guibg=black
hi normalfloat guibg=#001500
hi linenr guifg=dimgray
hi cursorlinenr guifg=#fabd2f
hi number guifg=peachpuff
hi float guifg=peachpuff
hi boolean guifg=peachpuff
hi character guifg=peachpuff
hi macro guifg=mediumorchid
hi string guifg=peachpuff guibg=#1D1D1D
hi storageclass gui=italic guifg=darkorange
hi comment guifg=dimgray
hi operator guifg=peachpuff
hi delimiter guifg=peachpuff
hi todo guibg=darkred
hi function guifg=olivedrab
hi identifier guifg=cadetblue
hi structure guifg=#fabd2f
hi include guifg=mediumorchid
hi special guifg=#fe8019
hi preproc guifg=mediumorchid
hi directory guifg=olivedrab
hi title guifg=olivedrab

hi clear constant
]])

-- vim.cmd([[
-- let g:alduin_Shout_Fire_Breath=0 "1 = deep red for special highlight groups
-- let g:alduin_Shout_Aura_Whisper=0 "1 = remove block matchparens and add underline
-- let g:alduin_Shout_Dragon_Aspect=0 "1 = almost black background
-- let g:alduin_Shout_Become_Ethereal=1 "1 = black background
-- let g:alduin_Shout_Animal_Allegiance=0 "1 = remove string bg
-- color alduin
-- ]])

-- TODO move augroups and autocommands to pure lua
-- https://gist.github.com/numToStr/1ab83dd2e919de9235f9f774ef8076da
vim.cmd([[
augroup CursorLine
au!
au VimEnter,ColorScheme * set cursorline
au VimEnter,ColorScheme * hi clear cursorline
au VimEnter,ColorScheme * hi cursorlinenr guibg=background
augroup END

augroup Formatting
au!
au FileType javascript,javascriptreact,typescript,typescriptreact,json :set ts=2
au FileType javascript,javascriptreact,typescript,typescriptreact,json :set sts=0
augroup END

augroup MarkdownFiles
au!
au FileType markdown :set spell
au FileType markdown :set tw=0 " don't want auto line breaks in markdown
au FileType markdown nnoremap <buffer> <leader>mdu- yyp<s-v>r-
au FileType markdown nnoremap <buffer> <leader>mdu= yyp<s-v>r=
augroup END

augroup BashFiles
au!
au FileType sh :set tw=0
augroup END
]])
