# Karate Test Files

## Configuración de entornos

  En el archivo `karate-config.js` se encuentran las configuraciones de los entornos de integración, certificación y producción.

  En este archivo se debe configurar las URL y datos que se utilizaran segun cada entorno de pruebas

  Ejemplo:
  ```javascript
  function fn() {
      var env = karate.env; 

      if (!env) {
          env = 'dev'; 
      }
  
      var config = { 
          tokenUrl: ''
      };

      if (env == 'dev') {
          config.tokenUrl = 'https://urldevelopment.com',
     
      } else if (env == 'qa') {
          config.tokenUrl = 'https://urlcertification.com';

      } else if (env == 'prod') {
          config.tokenUrl = 'https://urlproduction.com';

      }
      
      return config;
  }
  ```

## Ejecución de Pruebas

### Ejecución Total 

Para ejecutar todos los escenarios de prueba, use el siguiente comando:

```bash
mvn clean test
```

### Ejecución por TAGS 

Los escenarios de prueba se definen en los archivos `.feature` en el directorio `src/test/java/bdd/feature`. Cada escenario está etiquetado con una etiqueta única para su fácil identificación y ejecución.

Por ejemplo, para ejecutar el escenario de prueba etiquetado con `@prueba`, use el siguiente comando:

```bash
mvn clean test -Dkarate.env="dev" -Dkarate.options="--tags @prueba"
```

## Reportes de Pruebas

Una vez finalizado la ejecución de las pruebas, se creará una carpeta `target`, donde encontrarás principalmente las carpetas:

- La carpeta `target/karate-reports`, en este directorio se encontrará el archivo reporte de Karate `karate-summary.html`, este archivo al abrirlo en tu navegador, contendrá el resumen de las pruebas realizadas por cada Feature, Tags o Timeline para ver cuantos hilos se ejecutaron en simultaneo.

- La carpeta `cucumber-html-reports`, en este directorio se encontrará el archivo reporte de Cucumber `overview-features.html`, este archivo al abrirlo en tu navegador, contendrá el resumen más detallado de la ejecución de Features, Tags, Steps, Failures. 
