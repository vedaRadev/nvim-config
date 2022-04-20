vim.opt.syntax         = 'off'
vim.opt.fileformats    = { 'unix', 'dos' }
vim.opt.number         = true
vim.opt.relativenumber = true
vim.opt.expandtab      = false
vim.opt.tabstop        = 2
vim.opt.shiftwidth     = 0
vim.opt.softtabstop    = 0
vim.opt.textwidth      = 120
vim.opt.wrap					 = true
vim.opt.linebreak			 = true
vim.opt.breakindent		 = true
vim.opt.hlsearch			 = false
vim.opt.termguicolors  = true
vim.opt.backspace			 = { 'eol', 'indent', 'start' }

vim.cmd[[command! W w]]
vim.cmd[[command! Q q]]
vim.cmd[[command! Qa qa]]

vim.cmd([[
color ayu
hi normal guibg=black
hi linenr guifg=slategrey
hi cursorline guibg=#292929
hi cursorlinenr guifg=hotpink
]])

-- TODO move augroups and autocommands to pure lua
-- https://gist.github.com/numToStr/1ab83dd2e919de9235f9f774ef8076da
vim.cmd([[
augroup CursorLine
	au!
	au VimEnter * setlocal cursorline
	au WinEnter * setlocal cursorline
	au BufWinEnter * setlocal cursorline
	au WinLeave * setlocal nocursorline
augroup END

augroup JavascriptCode
	au! 
	au FileType javascript,javascriptreact :iabbr <buffer> clog console.log
	au FileType javascript,javascriptreact :cabbr <buffer> clog console.log
augroup END

augroup MarkdownFiles
  au!

  au FileType markdown :set spell
  au FileType markdown :set tw=0 " don't want auto line breaks in markdown
  au FileType markdown nnoremap <buffer> <leader>mdu- yyp<s-v>r-
  au FileType markdown nnoremap <buffer> <leader>mdu= yyp<s-v>r=
augroup END
]])
