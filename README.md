This module provides a useful help to create the necessary configuration and run Prettier ESLint and Git Hooks with the repositories of [@scastro37/prettier-config](https://github.com/scastro37/prettier-config) and [@scastro37/eslint-config](https://github.com/scastro37/eslint-config)

## Compatibility

- npm v7 or higher.

## How to use it
To use the library you just need to follow the following steps:

- Run the script with npx
```js
npx @scastro37/matchbox
```
- Select the option to install.
```js
Install or Uninstall? (i/u) [i]: i
```
- Select the type of project **JavaScript** or **TypeScript**
```js
JavaScript or TypeScript? (js/ts) [js]:
```
- List space-separated folders or files, which you want to ignore in configuration.
```js
Omit directories or files (separate with space): node_modules dist *.svg
```
- At the end of the installation the script run **lint-global**, which will format and analyze errors and warnings in all project files.

Note:
To analyze and correct errors with ESLint run the following script **npm run lint**

### Description Script
The script makes the following changes to our project
- Removes all ESLint and Prettier settings it finds.
- It will install the following dependencies **eslint@7.23.0, @scastro37/prettier-config, @scastro37/eslint-config, husky@6.0.0**
- It will add Prettier's configuration of [@scastro37/prettier-config](https://github.com/scastro37/prettier-config) and will also add the ESLint's configuration of [@scastro37/eslint-config](https://github.com/scastro37/eslint-config).
- It will create **.prettierignore** and **.eslintignore** to ignore directories or files.
- It will create the configuration in **.husky** and add **lint-satged** to file **package.json** for the execution of **pre-commit**
- Add Prettier and ESLint execution script to **package.json**
- A small configuration is added in **.vscode/settings.json** to be able to use when saving changes.
```js
{
  "[typescript]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode",
    "editor.formatOnSave": true
  },
  "[javascript]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode",
    "editor.formatOnSave": true
  }
}
```

## How to Uninstall

- Run the script with npx
```js
npx @scastro37/matchbox
```
- Select the option to uninstall
```js
Install or Uninstall? (i/u) [i]: u
```
### Description Uninstall Script

- Removes the configuration files from **ESLint** y **Prettier**
- Removes configuration created in the **package.json**
- Uninstall dependencies **eslint, @scastro37/prettier-config, @scastro37/eslint-config, husky**

## Contributors

The original author and current lead maintainer of this module is the [@condor-labs development team](https://condorlabs.io/team).

**More about Condorlabs [Here](https://condorlabs.io/about).**

## License

[MIT](LICENSE)
