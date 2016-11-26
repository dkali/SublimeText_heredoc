#!/bin/bash

st_pkg_folder="c:/Program Files/Sublime Text 3/Packages"
syntax_pkg="/Ruby.sublime-package"
tmp_folder="/Ruby"
syntax_file="/Ruby.sublime-syntax"
# patch_file="/st_herodoc_disable.patch"
patch_file="/st_back_to_old_heredoc_syntax.patch"

check_file_presence(){
  if [ ! -f "$1" ]; then
    echo "ERROR: Ruby.sublime-package file not found!"
    exit 404
  fi
}
remove_folder_if_exist(){
  if [ -d "$1" ]; then
    rm -rf "$1"
  fi
}


check_file_presence "$st_pkg_folder$syntax_pkg"

remove_folder_if_exist "$st_pkg_folder$tmp_folder"
unzip -q "$st_pkg_folder$syntax_pkg" -d "$st_pkg_folder$tmp_folder"
check_file_presence "$PWD$patch_file"

patch "$st_pkg_folder$tmp_folder$syntax_file" "$PWD$patch_file"

appdata_folder=$(env | grep "^APPDATA=" | cut -d= -f2-)
p=$(echo "$appdata_folder/Sublime Text 3/Packages/Ruby" | sed -r 's@\\@/@g' )
remove_folder_if_exist "$p"

p=$(echo "$appdata_folder/Sublime Text 3/Packages/" | sed -r 's@\\@/@g' )
mv "$st_pkg_folder$tmp_folder" "$p"

exit $?