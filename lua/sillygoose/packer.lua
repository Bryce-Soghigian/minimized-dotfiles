-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  
  -- File Explorer + Search
  use 'nvim-telescope/telescope.nvim'

  -- Color Schemes
  -- use "EdenEast/nightfox.nvim"
end)

