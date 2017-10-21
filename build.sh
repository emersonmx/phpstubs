#!/bin/bash

set -e

filename='netbeans-8.2-201609300101-php.zip'
checksum='51ae034b99f16c3bab66ab7dfd07c3554953e78828c2493cde1bb67c95c43e2b'
download_path="/tmp/$filename"
code_path='code'

pushd /tmp > /dev/null
curl -O -C - "http://download.netbeans.org/netbeans/8.2/final/zip/$filename"
popd > /dev/null

echo 'Checking...'
echo "$checksum *$download_path" | sha256sum -c - > /dev/null

echo 'Extracting...'
rm -rf $code_path
unzip -q -j $download_path "netbeans/php/phpstubs/phpruntime/*" -d $code_path/

echo 'Generating tags...'
ctags --fields=+aimlS --languages=php --tag-relative=never -R $code_path

echo 'Done'
