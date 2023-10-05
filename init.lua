-- PYTHON3_HOST_PROG is a required env var

vim.g.python3_host_prog = vim.env.PYTHON3_HOST_PROG -- may need to fnameescape somehow

if (vim.fn.has('win32') == 1) then
	-- Setting $HOME seems to only be necessary for windows machines.
	vim.env.HOME = vim.env.USERPROFILE
end

-- windows/wsl clipboard interop.
-- TODO could use env var for path to win32yank
-- for now just assuming its symlinked in a dir in /usr/bin
if (vim.fn.has('wsl') == 1) then
	vim.g.clipboard = {
		name = 'WslClipboard',
		copy = {
			['+'] = 'clip.exe',
			['*'] = 'clip.exe',
		},
		paste = {
			['+'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
			['*'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
		},
		cache_enable = 0
	}
end

require('init.config')
require('init.keybindings')
require('init.plugins')
