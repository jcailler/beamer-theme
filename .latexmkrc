# PDF with LuaLaTeX
$pdf_mode = 4;
$lualatex = 'lualatex --shell-escape --interaction=nonstopmode -synctex=1 -recorder --file-line-error %O %S';

# Files to be cleared
$clean_ext = "deriv equ glo gls gsprogs hd listing lol vrb fls" .
" _minted-%R/* _minted-%R nav snm synctex.gz tcbtemp vpprogs";

@default_files = ('example');