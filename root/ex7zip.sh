#!/bin/sh -x
#
# 7z archiving with LZMA2 compression and some encryption.
#
# (c) 2018, maxohm [ at ] gmail.com
#
cat=`which cat`
tar=`which tar`
xz=`which 7z`
ssl=`which openssl`
host=`/usr/bin/uname -n`
rm=`which rm`
#
$xz a -mtc=on -mx=9 -myx=9 -ssw -t7z -y -- $1.7z $1 > /dev/null
$cat $1.7z | $ssl enc -aes-256-cbc -k $host -e > $1.x
$rm -f $1.7z
#