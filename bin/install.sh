#!/usr/bin/env bash
bold=`tput bold`
normal=`tput sgr0`
grey=`tput setaf 8`

read -n 2 -p "${bold}JavaScript or TypeScript$*? ${normal}(js/ts) ${grey}[js]${normal}: " TYPE
echo
if test "$TYPE" = "js" -o "$TYPE" = "JS"; then
  TYPE='"@scastro37/eslint-config/configJS"';
elif test "$TYPE" = "ts" -o "$TYPE" = "TS"; then
  TYPE='"@scastro37/eslint-config/configTS"';
else
  TYPE='"@scastro37/eslint-config/configJS"'; fi

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
npm uninstall eslint husky
npm i eslint@7.23.0 @scastro37/prettier-config @scastro37/eslint-config @scastro37/matchbox husky@6.0.0 -D --force
ESLINT="module.exports = {extends: [${TYPE}]};"
PRETTIER='"@scastro37/prettier-config"'
SETTINGS='{
  "[javascript]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode",
    "editor.formatOnSave": true
  },
  "[typescript]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode",
    "editor.formatOnSave": true
  }
}'
GITIGNORE="node_modules"

printf "${PRETTIER} %s\n" > .prettierrc
printf "${ESLINT} %s\n" > .eslintrc.js

if [ -d .vscode ]; then 
  if [ ! -f .vscode/settings.json ]; then
    touch .vscode/setting.json; fi 
else touch .vscode/setting.json; fi;

touch .eslintignore .prettierignore

node ./node_modules/@scastro37/prettier-config/mrm-config

if [ -d node_modules ]; then
  if [ ! -f .gitignore ]; then
    printf "${GITIGNORE} %s\n" > .gitignore; fi
fi

RUTA=$( pwd )
while [[ $COUNT -ne 6 ]]
do
  if [ -d .git ]; then
    npx husky install
    npx husky add .husky/pre-commit "cd $RUTA && npx lint-staged"
    COUNT=$((5))
  else
    cd ..; fi
  COUNT=$(($COUNT+1))
done;

cd $RUTA
npm run lint-global