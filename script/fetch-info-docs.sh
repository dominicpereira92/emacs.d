#!/bin/bash

mkdir info
cd info

echo "Fetching GNU libc manual..."
wget http://www.gnu.org/software/libc/manual/info/libc-info.tar.gz
echo "Fetching GNU Emacs manual..."
wget http://www.gnu.org/software/emacs/manual/info/emacs.info.tar.gz
echo "Fetching GNU Emacs Lisp manual..."
wget http://www.gnu.org/software/emacs/manual/info/elisp.info.tar.gz
echo "Fetching GNU Guile manual..."
wget http://www.gnu.org/software/guile/manual/guile.info.tar.gz

echo "Installing GNU libc manual..."
tar xvf libc-info.tar.gz
ginstall-info libc.info dir-libc
echo "Installing GNU Emacs manual..."
tar xvf emacs.info.tar.gz
ginstall-info emacs dir-emacs
echo "Installing GNU Emacs Lisp manual..."
tar xvf elisp.info.tar.gz
ginstall-info elisp dir-elisp
echo "Installing GNU Guile manual..."
tar xvf guile.info.tar.gz
ginstall-info guile.info dir-guile

echo "Cleaning up..."
rm libc-info.tar.gz
rm emacs.info.tar.gz
rm elisp.info.tar.gz
rm guile.info.tar.gz
