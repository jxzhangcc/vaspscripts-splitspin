#!/bin/bash

# Written by Jing-Xuan Zhang from Sustech
# Please contact jxzhangcc@gmail.com if any problem

f=DOSCAR
nions=`sed -n '1p' ${f} | awk '{print $1}'`
wpartial=`sed -n '1p' ${f} | awk '{print $3}'`

nlines=`sed -n '6p' ${f} | awk '{print $3}'`
ispin=`sed -n '7p' ${f} | wc -w`

if [ "$ispin" == 3 ]; then
    echo 'Ispin=1. Nothing to split.'
    exit
elif [ "$ispin" != 5 ]; then
    echo 'Something went wrong. Data structure is not understood.'
    exit
fi

sed -n '1,6p' ${f} > ${f}_UP
sed -n '1,6p' ${f} > ${f}_DOWN
sed -n "7,$((nlines+6))p" ${f} | awk '{printf "%11s %11s %11s\n", $1, $2, $4}' >> ${f}_UP
sed -n "7,$((nlines+6))p" ${f} | awk '{printf "%11s %11s %11s\n", $1, $3, $5}' >> ${f}_DOWN

if [ "$wpartial" == 0 ]; then
    exit
fi

pt=$((nlines+7))
for iion in `seq $nions`; do
    nlines=`sed -n "${pt}p" ${f} | awk '{print $3}'`
    sed -n "${pt}p" ${f} >> ${f}_UP
    sed -n "${pt}p" ${f} >> ${f}_DOWN
    sed -n "$((pt+1)),$((pt+nlines))p" ${f} | sed -r 's/( +0\.[0-9]+E[+-][0-9]+)( +0\.[0-9]+E[+-][0-9]+)/\1/g' >> ${f}_UP
    sed -n "$((pt+1)),$((pt+nlines))p" ${f} | sed -r 's/( +0\.[0-9]+E[+-][0-9]+)( +0\.[0-9]+E[+-][0-9]+)/\2/g' >> ${f}_DOWN
    pt=$((pt+nlines+1))
done

ntail=`sed -n "${pt},\\\$p" ${f} | wc -w`
if [ "$ntail" != 0 ]; then
    echo "There is something in the end of file whose data structure is not understood. Please check."
fi

echo "${f} successfully split."


