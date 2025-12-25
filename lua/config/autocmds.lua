-- Add any autocmds here

vim.cmd([=[autocmd Filetype lua inoremap <buffer> <leader>acm vim.cmd([[autocmd Filetype lua inoremap ]])<Esc>hhi]=])

vim.cmd([=[autocmd Filetype lua nnoremap <buffer> <leader>r :Lazy update]=])

-- Reset per i file C
vim.cmd([=[autocmd FileType c inoremap <buffer> prt printf("\n");<Left><Left><Left><Left><Left>]=])
vim.cmd([=[autocmd FileType c inoremap <buffer> scn scanf("");<Left><Left><Left>]=])
vim.cmd([=[autocmd FileType c inoremap <buffer> ,, /* */<Left><Left>]=])
vim.cmd([=[autocmd FileType c inoremap <buffer> main int main(int argc, char *argv[]) {<CR>return 0;<CR>}<Esc>kf(i]=])
vim.cmd([=[autocmd FileType c inoremap <buffer> forl for (int i = 0; i < count; i++) {<CR>}<Esc>kf(fcf ]=])
vim.cmd([=[autocmd FileType c inoremap <buffer> ifc if () {<CR>}<Esc>kf(a]=])
vim.cmd([=[autocmd FileType c inoremap <buffer> whilel while () {<CR>}<Esc>kf(a]=])
vim.cmd([=[autocmd FileType c inoremap <buffer> #switch switch () {<CR>case :<CR>break;<CR>default:<CR>}<Esc>4kf(a]=])
vim.cmd([=[autocmd FileType c inoremap <buffer> sio #include <stdio.h>]=])
vim.cmd([=[autocmd FileType c inoremap <buffer> strc struct  {<CR>};<Esc>kf{bi]=])
vim.cmd(
    [=[autocmd FileType c inoremap <buffer> fn<CR> voidacm vim.cmd([[autocmd Filetype lua inoremap ]]) () {<CR>}<Esc>kf(hi]=]
)
vim.cmd([=[autocmd FileType c inoremap <buffer> #def #define  ]=])
