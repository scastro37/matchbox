#!/usr/bin/env bash
bold=`tput bold`
normal=`tput sgr0`
grey=`tput setaf 8`

read -n 1 -p "${bold}Install or Uninstall$*? ${normal}(i/u) ${grey}[i]${normal}: " ACTION
echo 
if test "$ACTION" = "i" -o "$ACTION" = "I"; then 
  pwd
  bash ./bin/install.sh;
  
elif test "$ACTION" = "u" -o "$ACTION" = "U"; then
  if [ -f .eslintrc.js ];then rm .eslintrc.js;fi  
  if [ -f .eslintrc.json ];then rm .eslintrc.json;fi
  if [ -f .eslintrc ];then rm .eslintrc;fi
  if [ -f .estint.config.js ];then rm .estint.config.js;fi
  if [ -f .estint.config.json ];then rm .estint.config.json;fi
  if [ -f .prettierrc.js ];then rm .prettierrc.js;fi
  if [ -f .prettierrc.json ];then rm .prettierrc.json;fi
  if [ -f .prettierrc ];then rm .prettierrc;fi
  if [ -f .prettier.config.js ];then rm .prettier.config.js;fi
  if [ -f .prettier.config.json ];then rm .prettier.config.json;fi
  if [ -f .prettierignore ]; then rm .prettierignore; fi
  if [ -f .eslintignore ]; then rm .eslintignore; fi

  node ./node_modules/@scastro37/prettier-config/mrm-uninstall
  npm uninstall eslint @scastro37/prettier-config @scastro37/eslint-config @scastro37/matchbox husky -D
  rm -rf .husky
  rm -rf node_modules
  rm package-lock.json
  npm i;
else 
  pwd
  bash ./bin/install.sh; fi
