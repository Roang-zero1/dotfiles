vim.g.mapleader = " "
require('plugins')
require('lualine').setup()
vim.opt.completeopt={'menuone','noinsert', 'noselect'}
vim.opt.mouse='a'
vim.opt.splitright=true
vim.opt.splitbelow=true
vim.opt.expandtab = true
vim.opt.tabstop=2
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.diffopt = vim.opt.diffopt + "vertical"
vim.opt.signcolumn="yes"
vim.opt.updatetime=750
if vim.fn.has("termguicolors")
then
  vim.opt.termguicolors = true
end

vim.cmd.colorscheme('dracula')

vim.api.nvim_set_keymap(
  "n",
  "<leader>v",
  ":e $MYVIMRC<cr>",
  { noremap = true }
 )

vim.g.netrw_banner=0
vim.g.markdown_fenced_languages={'javascript', 'js=javascript', 'json=javascript'}

