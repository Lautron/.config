snipFolder="/home/lautarob/.nvim/plugged/vim-snippets/UltiSnips/"
for file in *.snippets ; do
  echo "linking $file to $snipFolder"
  ln -f $file $snipFolder
done
