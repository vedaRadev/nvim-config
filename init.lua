-- PYTHON3_HOST_PROG is a required env var

vim.g.python3_host_prog = vim.env.PYTHON3_HOST_PROG -- may need to fnameescape somehow

if (vim.fn.has('win32')) then
	-- Setting $HOME seems to only be necessary for windows machines.
	vim.env.HOME = vim.env.USERPROFILE
end

-- windows/wsl clipboard interop.
-- TODO could use env var for path to win32yank
-- for now just assuming its symlinked in a dir in /usr/bin
if (vim.fn.has('wsl')) then
	vim.g.clipboard = {
		name = 'win32yank-wsl',
		copy = {
			['+'] = '/usr/bin/win32yank/win32yank.exe -i --crlf',
			['*'] = '/usr/bin/win32yank/win32yank.exe -i --crlf',
		},
		paste = {
			['+'] = '/usr/bin/win32yank/win32yank.exe -o --crlf',
			['*'] = '/usr/bin/win32yank/win32yank.exe -o --crlf',
		},
		cache_enable = 0
	}
end

require('init.config')
require('init.keybindings')
require('init.plugins')
