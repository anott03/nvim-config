" Automatically generated packer.nvim plugin loader code

if !has('nvim-0.5')
  echohl WarningMsg
  echom "Invalid Neovim version for packer.nvim!"
  echohl None
  finish
endif

packadd packer.nvim

try

lua << END
local package_path_str = "/home/amitav/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/amitav/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/amitav/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/amitav/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/amitav/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    print('Error running ' .. component .. ' for ' .. name)
    error(result)
  end
  return result
end

_G.packer_plugins = {
  ["colorbuddy.vim"] = {
    loaded = true,
    path = "/home/amitav/.local/share/nvim/site/pack/packer/start/colorbuddy.vim"
  },
  ["emmet-vim"] = {
    loaded = true,
    path = "/home/amitav/.local/share/nvim/site/pack/packer/start/emmet-vim"
  },
  gruvbox = {
    loaded = true,
    path = "/home/amitav/.local/share/nvim/site/pack/packer/start/gruvbox"
  },
  ["gruvbuddy.nvim"] = {
    loaded = true,
    path = "/home/amitav/.local/share/nvim/site/pack/packer/start/gruvbuddy.nvim"
  },
  ["lsp_extensions.nvim"] = {
    loaded = true,
    path = "/home/amitav/.local/share/nvim/site/pack/packer/start/lsp_extensions.nvim"
  },
  ["lspsaga.nvim"] = {
    loaded = true,
    path = "/home/amitav/.local/share/nvim/site/pack/packer/start/lspsaga.nvim"
  },
  ["lualine.nvim"] = {
    loaded = true,
    path = "/home/amitav/.local/share/nvim/site/pack/packer/start/lualine.nvim"
  },
  nerdcommenter = {
    loaded = true,
    path = "/home/amitav/.local/share/nvim/site/pack/packer/start/nerdcommenter"
  },
  ["nvim-compe"] = {
    loaded = true,
    path = "/home/amitav/.local/share/nvim/site/pack/packer/start/nvim-compe"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/home/amitav/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-terminal.lua"] = {
    loaded = true,
    path = "/home/amitav/.local/share/nvim/site/pack/packer/start/nvim-terminal.lua"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/home/amitav/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/amitav/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  ["onedark.vim"] = {
    loaded = true,
    path = "/home/amitav/.local/share/nvim/site/pack/packer/start/onedark.vim"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/amitav/.local/share/nvim/site/pack/packer/start/packer.nvim"
  },
  playground = {
    loaded = true,
    path = "/home/amitav/.local/share/nvim/site/pack/packer/start/playground"
  },
  ["rust.vim"] = {
    loaded = true,
    path = "/home/amitav/.local/share/nvim/site/pack/packer/start/rust.vim"
  },
  undotree = {
    loaded = true,
    path = "/home/amitav/.local/share/nvim/site/pack/packer/start/undotree"
  },
  ["vim-be-good"] = {
    loaded = true,
    path = "/home/amitav/.local/share/nvim/site/pack/packer/start/vim-be-good"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/home/amitav/.local/share/nvim/site/pack/packer/start/vim-fugitive"
  },
  ["vim-startify"] = {
    loaded = true,
    path = "/home/amitav/.local/share/nvim/site/pack/packer/start/vim-startify"
  },
  vimwiki = {
    loaded = true,
    path = "/home/amitav/.local/share/nvim/site/pack/packer/start/vimwiki"
  }
}

END

catch
  echohl ErrorMsg
  echom "Error in packer_compiled: " .. v:exception
  echom "Please check your config for correctness"
  echohl None
endtry
