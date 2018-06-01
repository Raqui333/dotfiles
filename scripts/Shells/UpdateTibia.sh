#!/bin/bash

script_path=$(readlink -f "$0")
script_dir=$(dirname "$script_path")

echo -e "\033[1;32mDownloading tibia in\033[00m: ${script_dir}\n"
wget -cq --show-progress --progress=bar "http://download.tibia.com/tibia.x64.tar.gz" -P ${script_dir}

echo -e "\033[1;32mExtracting tibia files in\033[00m: ${script_dir}\n"
tar xf ${script_dir}/tibia.*.tar.gz

echo -e "\033[1;32mUpdating tibia in\033[00m: ${script_dir}\n"
cp -r ${script_dir}/tibia-*/* ${script_dir}
