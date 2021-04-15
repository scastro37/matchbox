Este módulo proporciona una ayuda útil para crear la configuracion nencesaria y ejecutar Prettier ESLint y Git Hooks con los repositorios de [@scastro37/prettier-config](https://github.com/scastro37/prettier-config) y [@scastro37/eslint-config](https://github.com/scastro37/eslint-config)

## Compatibility

- npm v7 or higher.

## How to use it
To use the library you just need to follow the following steps:

- Run the script with npx
```js
npx @scastro37/matchbox
```
- Selecciona la opcion de instalar 
```js
Install or Uninstall? (i/u) [i]: i
```
- Selecciona el tipo de proyecto **JavaScript** o **TypeScript**
```js
JavaScript or TypeScript? (js/ts) [js]:
```
- Listar capetas o archivos separados por espacio, que se quiere ignorar en la configuracion
´´´js
Omit directories or files (separate with space): node_modules dist *.svg
´´´
- Al final de la instalacion se ejecutar el script de **lint-global** el cual realizara el formato y analizara errores y advertencias en todos los archivos del proyecto

Nota:
Para analizar y corregir errores con ESLint ejecutar el script **npm run lint**

### Description Script
El script realiza los siguientes cambio en nuestro poryecto
- Remueve toda la configuracion de ESLint y Prettier que encuentre.
- Instala las siguintes dependecias **eslint@7.23.0, @scastro37/prettier-config, @scastro37/eslint-config, husky@6.0.0**
- Agrega la configuracion de Prettier de [@scastro37/prettier-config](https://github.com/scastro37/prettier-config) y tambien agrega la configuración de ESLint de [@scastro37/eslint-config](https://github.com/scastro37/eslint-config).
- Crea **.prettierignore** y **.eslintignore** para ignorar directorios o archivos.
- Crea la configuracion en **.husky** y añade **lint-satged** al archivo **package.json** para la ejecucion de **pre-commit**
- Añade script de ejecucion de Prettier y ESLint al **package.json**
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
- Seleccione la opcion de desinstalar
```js
Install or Uninstall? (i/u) [i]: u
```
### Description Uninstall Script

- Remueve los archivos de configuracion de **ESLint** y **Prettier**
- Remueve configuracion creada en el **package.json**
- Desinstala las dependencias **eslint, @scastro37/prettier-config, @scastro37/eslint-config, husky**

## Contributors

The original author and current lead maintainer of this module is the [@condor-labs development team](https://condorlabs.io/team).

**More about Condorlabs [Here](https://condorlabs.io/about).**

## License

[MIT](LICENSE)
