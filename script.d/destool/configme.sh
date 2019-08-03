cd $PATH_XTOOLS/script.d/destool
make && make clean
cd -

ln -s $PATH_XTOOLS/script.d/destool/destool $PATH_XTOOLS/link.d/destool
