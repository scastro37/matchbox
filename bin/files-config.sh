#!/usr/bin/env bash
bold=`tput bold`
normal=`tput sgr0`
grey=`tput setaf 8`
red=`tput setaf 1`

dependencies="eslint@6.2.2 \
@scastro37/prettier-config@latest \
@scastro37/eslint-config@latest \
@scastro37/matchbox@latest \
husky@6.0.0 \
mrm-core@6.1.2 \
prettier@1.19.0 \
@babel/eslint-parser@7.14.7 \
@babel/plugin-transform-runtime@7.14.5 \
@typescript-eslint/eslint-plugin@4.28.4 \
@typescript-eslint/parser@4.0.0 \
babel-eslint@10.1.0 \
eslint-config-prettier@8.3.0 \
eslint-config-standard@16.0.3 \
eslint-plugin-import@2.22.1 \
eslint-plugin-jsx-a11y@6.4.1 \
eslint-plugin-node@11.1.0 \
eslint-plugin-prettier@3.4.0 \
eslint-plugin-promise@5.1.0 \
eslint-plugin-react@7.24.0 \
react@17.0.2"

husky='#!/bin/sh
  if [ -z "$husky_skip_init" ]; then
    debug () {
      [ "$HUSKY_DEBUG" = "1" ] && echo "husky (debug) - $1"
    }

    readonly hook_name="$(basename "$0")"
    debug "starting $hook_name..."

    if [ "$HUSKY" = "0" ]; then
      debug "HUSKY env variable is set to 0, skipping hook"
      exit 0
    fi

    if [ -f ~/.huskyrc ]; then
      debug "sourcing ~/.huskyrc"
      . ~/.huskyrc
    fi

    export readonly husky_skip_init=1
    sh -e "$0" "$@"
    exitCode="$?"

    if [ $exitCode != 0 ]; then
      echo "husky - $hook_name hook exited with code $exitCode (error)"
      exit $exitCode
    fi

    exit 0
  fi'

AskType(){
  read -n 2 -p "${bold}JavaScript or TypeScript$*? ${normal}(js/ts) ${grey}[js]${normal}: " TYPE
  echo
  if test "$TYPE" = "js" -o "$TYPE" = "JS"; then
    TYPE='"@scastro37/eslint-config/configJS"';
  elif test "$TYPE" = "ts" -o "$TYPE" = "TS"; then
    TYPE='"@scastro37/eslint-config/configTS"';
  else
    TYPE='"@scastro37/eslint-config/configJS"'; fi
}

CreateCodeOwnersFile(){
  CODEOWNERSTEXT=""

  eslintignoreText=".eslintignore @cebroker/architecture-team"
  eslintrcText=".eslintrc.js @cebroker/architecture-team"
  prettierignoreText=".prettierignore @cebroker/architecture-team"
  prettierrcText=".prettierrc @cebroker/architecture-team"

  eslintignoreExists=false;
  eslintrcExists=false;
  prettierignoreExists=false;
  prettierrcExists=false;

  if [ ! -f CODEOWNERS ]; then
    CODEOWNERSTEXT="${CODEOWNERSTEXT}${eslintignoreText}
${eslintrcText}
${prettierignoreText}
${prettierrcText}"

    printf "${CODEOWNERSTEXT}" > CODEOWNERS;
  else
    while read line;
    do
      if [ "$line" == "$eslintignoreText" ]; then
        eslintignoreExists=true
      elif [ "$line" == "$eslintrcText" ]; then
        eslintrcExists=true
      elif [ "$line" == "$prettierignoreText" ]; then
        prettierignoreExists=true
      elif [ "$line" == "$prettierrcText" ]; then
        prettierrcExists=true
      fi
    done < CODEOWNERS;

    if [ $eslintignoreExists == false ]; then
      CODEOWNERSTEXT="${CODEOWNERSTEXT}${eslintignoreText}
"
    fi

    if [ $eslintrcExists == false ]; then
      CODEOWNERSTEXT="${CODEOWNERSTEXT}${eslintrcText}
"
    fi

    if [ $prettierignoreExists == false ]; then
      CODEOWNERSTEXT="${CODEOWNERSTEXT}${prettierignoreText}
"
    fi

    if [ $prettierrcExists == false ]; then
      CODEOWNERSTEXT="${CODEOWNERSTEXT}${prettierrcText}
"
    fi

    if [ "$CODEOWNERSTEXT" != "" ]; then
      echo "${CODEOWNERSTEXT}" > temp_codeOwners;
      cat CODEOWNERS >> temp_codeOwners;
      mv temp_codeOwners CODEOWNERS
    fi
  fi
}

RunInstall(){
  find . -type d -name node_modules -prune -false -o -name '.eslint**' ! -name '.eslintignore' -delete
  find . -type d -name node_modules -prune -false -o -name '.prettier**' ! -name '.prettierignore' -delete
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
  npm i ${dependencies} -D -E --force
  ESLINT="module.exports = {extends: [${TYPE}]};"
  PRETTIER='"@scastro37/prettier-config"'
  GITIGNORE="node_modules"

  printf "${PRETTIER} %s\n" > .prettierrc
  printf "${ESLINT} %s\n" > .eslintrc.js

  if [ -d .vscode ]; then
    if [ ! -f .vscode/settings.json ]; then
      touch .vscode/setting.json; fi
  else touch .vscode/setting.json; fi;

  touch .eslintignore .prettierignore

  SEARCH_PACKAGES=$( find . -type d -name node_modules -prune -false -o -name 'package.json' )
  node ./node_modules/@scastro37/prettier-config/mrm-remove $SEARCH_PACKAGES

  node ./node_modules/@scastro37/prettier-config/mrm-config $LISTIGNORE

  if [ -d node_modules ]; then
    if [ ! -f .gitignore ]; then
      printf "${GITIGNORE} %s\n" > .gitignore; fi
  fi

  CreateCodeOwnersFile

  RUTA=$( pwd )
  while [[ $COUNT -ne 6 ]]
  do
    if [ -d .git ]; then
      mkdir -p .husky && cd .husky && mkdir -p _ && cd _ && touch husky.sh
      printf "${husky}" > husky.sh

      wait $pid

      cd ..;

      preCommitExists=false;

      if [ -f pre-commit ]; then
        while read line;
        do
          if [ "$line" == "npx lint-staged@9.5.0" ]; then
            preCommitExists=true
          fi
        done < pre-commit;


        if [ "$preCommitExists" = false ]; then
          npx husky add pre-commit "npx lint-staged@9.5.0"
        fi
      else
        npx husky add pre-commit "npx lint-staged@9.5.0"
      fi

      cd ..;

      COUNT=$((5))
    else
      cd ..; fi
    COUNT=$(($COUNT+1))
  done;

  cd $RUTA
  npm run lint-global

  cd .husky
  rm .gitignore
}

Install(){
  read -p "${bold}Omit directories or files$* ${normal}${grey}(separate with space)${normal}: " LISTIGNORE
  if [ "$LISTIGNORE" ]; then
    echo "[${red}$LISTIGNORE${normal}]"
    read -n 1 -p "${bold}$*Are you sure you want to ignore these files/directories? ${normal}(y/n) ${grey}[y]${normal}: " CONFIRM
  else
    read -n 1 -p "${bold}$*Sure you don't want to ignore any files/directories? ${normal}(y/n) ${grey}[y]${normal}: " CONFIRM; fi

  if test "$CONFIRM" = "y" -o "$CONFIRM" = "Y"; then
    echo
    RunInstall

  elif test "$CONFIRM" = "n" -o "$CONFIRM" = "N"; then
    echo
    Install
  else
    echo
    RunInstall; fi
}

read -n 1 -p "${bold}Install or Uninstall$*? ${normal}(i/u) ${grey}[i]${normal}: " ACTION
echo
if test "$ACTION" = "i" -o "$ACTION" = "I"; then
  AskType
  Install;

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

  node ./node_modules/@scastro37prettier-config/mrm-uninstall
  npm uninstall ${dependencies} -D
  rm -rf .husky
  rm -rf node_modules
  rm package-lock.json
  npm i;
else
  AskType
  Install; fi
