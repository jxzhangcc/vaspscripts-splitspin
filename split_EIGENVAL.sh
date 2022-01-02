#!/bin/bash

# Written by Jing-Xuan Zhang from Sustech
# Please contact jxzhangcc@gmail.com if any problem

f=EIGENVAL

sed -r 's/^( +[0-9]+  )( +-?[0-9]+\.[0-9]+)( +-?[0-9]+\.[0-9]+)( +-?[0-9]+\.[0-9]+)( +-?[0-9]+\.[0-9]+)$/\1\2\4/g' ${f} > ${f}_UP
sed -r 's/^( +[0-9]+  )( +-?[0-9]+\.[0-9]+)( +-?[0-9]+\.[0-9]+)( +-?[0-9]+\.[0-9]+)( +-?[0-9]+\.[0-9]+)$/\1\3\5/g' ${f} > ${f}_DOWN

echo "${f} successfully split."


