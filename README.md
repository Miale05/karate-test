# Booker API Karate Automation Framework

## Objetivo

Este proyecto tiene como objetivo automatizar la API con los endpoint de los servicios web de Booking, utilizando el lenguaje y framework preferido.

## Alcance 

- Este proyecto contempla solamente la automatización de los servicios web Authorization, Booking y Health, en esta documentación [Booker API Documentation](https://restful-booker.herokuapp.com/apidoc/index.html).
- Se implementará la automatización utilizando KarateDSL con patron BDD en lenguaje Gherkin para los features y Java para Utils y ejecución. (Opcionalmente se puede crear Utils tambien en lenguaje JavaScript)
- Se brindará el reporte de la prueba en formato HTML.

## Puntos de Mejora

- Se debe tener un mayor conocimiento de los codigos de error soportados para cada Endpoint, visualizando quiza un contrato en SwaggerHub.
- Se debe tener los endpoint para ambientes de Desarrollo, Certificación y Producción para que de esta manera se pueda separar correctamente los valores a usar por cada ambiente.

## Introducción

Este proyecto utiliza el framework de Karate DSL. Karate DSL es un framework de automatización de pruebas de API basado en Cucumber BDD para Java, permitiendo así escribir pruebas de servicios web y API de manera rapida, sencilla y facil de leer, ya que se utiliza lenguaje Gherkin. Ademas, de tener versatilidad de utilizar Java o JavaScript

> [Booker API Documentation](https://restful-booker.herokuapp.com/apidoc/index.html)


## Estructura del Proyecto

La estructura del proyecto es la siguiente:

- `src/test/java/bookerapi/feature`: Este directorio contiene los archivos de características que definen los escenarios de prueba.
- `src/test/java/karate-config.js`: Este archivo contiene la configuración para las pruebas de Karate.
- `src/test/java/bookerapi/TestRunner.java`: Este archivo contiene la configuración de ejecución de las pruebas.
- `src/test/java/bookerap/resources`: Este directorio contiene los archivos de recursos y utilidades para las pruebas.

## Casos de Prueba

  En los siguientes archivos se encontrarán distintos casos:
   
   - En el archivo `CreateToken.feature`, se muestran escenarios POST que prueban la funcionalidad de generar la autenticación.
   - En el archivo `CreateBooking.feature`, se muestran escenarios POST que prueban la funcionalidad de generar crear una reserva.
   - En el archivo `DeleteBooking.feature`, se muestran escenarios DELETE que prueban la funcionalidad de eliminar una reserva.
   - En el archivo `GetBooking.feature`, se muestran escenarios GET que prueban la funcionalidad de consultar detalles de una reserva.
   - En el archivo `GetBookingIDs.feature`, se muestran escenarios GET que prueban la funcionalidad de listar una consulta de IDs de las reservas.
   - En el archivo `PatchBooking.feature`, se muestran escenarios PATCH que prueban la funcionalidad de actualizar campos especificos de una reserva.
   - En el archivo `UpdateBooking.feature`, se muestran escenarios UPDATE que prueban la funcionalidad de actualizar totalmente una reserva.
   - En el archivo `HealthCheck.feature`, se muestran escenarios GET que prueban la funcionalidad de consultar el estado del servicio.

## Configuración de entornos

  En el archivo `karate-config.js` se encuentran las configuraciones de los entornos de integración, certificación y producción.

  En este archivo se debe configurar las URL y datos que se utilizaran segun cada entorno de pruebas

  Ejemplo:
  ```javascript
  function fn() {
      var env = karate.env; 
      if (!env) {
          env = 'qa'; 
      }
  
      var config = { 
          tokenUrl: 'https://urldevelopment.com',
        
      };
      if (env == 'qa') {
          config.tokenUrl = 'https://urlcertification.com',
     
      } else if (env == 'prod') {
          config.tokenUrl = 'https://urlproduction.com';

      }
      
      return config;
  }
  ```

## Ejecución de Pruebas

### Ejecución Total 

Para ejecutar todos los escenarios de prueba, use el siguiente comando:

Para Linux/Mac:
```bash
mvn test
```

Para Windows:
```bash
mvn test --%
```

### Ejecución por TAGS 

Los escenarios de prueba se definen en los archivos `.feature` en el directorio `src/test/java/bookerapi/feature`. Cada escenario está etiquetado con una etiqueta única para su fácil identificación y ejecución.

Por ejemplo, para ejecutar el escenario de prueba etiquetado con `@token`, use el siguiente comando:

Para Linux/Mac:
```bash
mvn test -Dkarate.options="--tags @token"
```

Para Windows:
```bash
mvn test --% -Dkarate.options="--tags @token"
```

## Reportes de Pruebas

Una vez finalizado la ejecución de las pruebas, se creará una carpeta `target`, donde encontrarás principalmente las carpetas:

- La carpeta `target/karate-reports`, en este directorio se encontrará el archivo reporte de Karate `karate-summary.html`, este archivo al abrirlo en tu navegador, contendrá el resumen de las pruebas realizadas por cada Feature, Tags o Timeline para ver cuantos hilos se ejecutaron en simultaneo.

- La carpeta `cucumber-html-reports`, en este directorio se encontrará el archivo reporte de Cucumber `overview-features.html`, este archivo al abrirlo en tu navegador, contendrá el resumen más detallado de la ejecución de Features, Tags, Steps, Failures. 
