if (vim.fn.has('win32') == 1) then
    vim.opt.fileformats = { 'dos' }
else
    vim.opt.fileformats = { 'unix' }
end

vim.opt.syntax          = 'off'
vim.opt.number          = true
vim.opt.relativenumber  = true
vim.opt.expandtab       = true
vim.opt.tabstop         = 4
vim.opt.shiftwidth      = 0
vim.opt.softtabstop     = 4
vim.opt.textwidth       = 100
vim.opt.wrap			= false
vim.opt.linebreak		= true
vim.opt.breakindent	    = true
vim.opt.hlsearch		= false
vim.opt.termguicolors   = true
vim.opt.backspace		= { 'eol', 'indent', 'start' }
vim.opt.signcolumn      = 'yes'
vim.opt.backup          = false
vim.opt.cmdheight       = 1
vim.opt.updatetime      = 300
vim.opt.cursorline      = true

vim.opt.shortmess:append('c')

vim.cmd[[command! W w]]
vim.cmd[[command! Q q]]
vim.cmd[[command! Qa qa]]

vim.cmd([[
"hi normal guifg=#d3d7cf guibg=#060606
hi normal guifg=#d3d7cf guibg=black
hi normalfloat guibg=#062006
hi linenr guifg=dimgray
hi cursorlinenr guifg=#fb9900
hi cursorline guibg=#380000
"hi visual guifg=black guibg=#707070
hi visual guifg=clear guibg=#400000
hi constant guifg=#d3d7cf
hi number guifg=#d3d7cf
hi float guifg=#d3d7cf
hi boolean guifg=#d3d7cf
hi character guifg=#d3d7cf
hi macro guifg=#c853ff
hi string guifg=#d3d7cf guibg=#262626
hi character guifg=#d3d7cf guibg=#262626
hi storageclass guifg=#ec1f1f gui=none
hi comment guifg=#707070
hi operator guifg=#d3d7cf
hi delimiter guifg=#d3d7cf
hi function guifg=#7ca900
hi identifier guifg=#d3d7cf
hi statement guifg=#d3d7cf
hi structure guifg=#fb9900
hi type guifg=#fb9900
hi include guifg=#c853ff
hi special guifg=#4ba2ff
hi preproc guifg=#c853ff
hi directory guifg=#7ca900
hi title guifg=#7ca900
hi underlined guifg=#c853ff
hi keyword guifg=#ec1f1f
hi conditional guifg=#ec1f1f
hi repeat guifg=#ec1f1f
hi specialchar guifg=#4ba2ff
hi exception guifg=#ec1f1f


hi DiagnosticError guifg=#ec1f1f
hi DiagnosticUnderlineError guisp=#ec1f1f

hi DiagnosticWarn guifg=#fb9900
hi DiagnosticUnderlineWarn guisp=#fb9900

hi DiagnosticInfo guifg=#4ba2ff
hi DiagnosticUnderlineInfo guisp=#4ba2ff

hi DiagnosticHint guifg=#c853ff
hi DiagnosticUnderlineHint guisp=#c853ff

hi DiagnosticOk guifg=#7ca900

"kind of a bastardization of what hi! link is for I guess
hi! link diffLine special
hi! link diffAdded function
hi! link diffRemoved keyword
hi! link @function.macro macro
hi! link @lsp.type.procmacro macro
hi! link @lsp.type.macro macro
hi! link @lsp.type.enummember clear
hi! link @lsp.typemod.variable.callable function

hi spellbad guifg=#ec1f1f

hi todo guifg=black guibg=#fb9900
hi! link @comment.todo.comment todo

hi @string.yaml guibg=background
hi @variable guifg=#d3d7cf
"hi @comment.todo.comment guifg=black guibg=#fb9900
hi @comment.warn.comment guifg=black guibg=#fb9900
hi @comment.note.comment guifg=black guibg=#4ba2ff
hi @comment.error.comment guifg=black guibg=#ec1f1f
" Color taken from highlight category "special"
hi @string.special.url.comment gui=underline guifg=#4ba2ff guibg=clear
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
au WinEnter * setlocal cursorline
"au BufWinEnter * setlocal cursorline
au WinLeave * setlocal nocursorline
"au BufWinLeave * setlocal nocursorline
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

augroup TextWidth
au!
au FileType sh,html :set tw=0
augroup END
]])
