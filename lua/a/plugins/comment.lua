return {
    'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup({
            toggler = {
                -- this plugin does not evaluate <leader> to space
                line = ' cc',
                block = ' bc',
            },
            opleader = {
                line = ' c',
                block = ' b',
            }
        })
    end
}
