@tiposdocumentos
Feature: Realizar casos de prueba de lectura de diferentes tipos de documentos

    Background: Pasos generales para los scenarios
        Given url karate.get('baseUrl')
        * def dataJson = karate.get('dataJson')
        * def dataCsv = karate.get('dataCsv')
        * def schema_user_json = karate.get('schemaUser')
    
    @single
    Scenario: Verificar que se puede probar de manera singular
        Given path 'users/1'
        When method Get
        Then status 200
        And match response.data.first_name == "George"

    @examples
    Scenario Outline: Verificar que se puede probar con examples
        Given path 'users/<id>'
        When method Get
        Then status 200
        And match response.data.first_name == "<first_name>"

        Examples:
        | id | first_name  |
        | 1  | George     |
        | 2  | Janet      |
        | 3  | Emma       |
        | 4  | Eve        |
    
    @json
    Scenario: Verificar que se puede probar con data de JSON
        Given path karate.get('pathUser')
        When method Get
        Then status 200
        And match response.data.first_name == dataJson.first_name
        * print "data en JSON, ambiente: " + karate.env 
        * print dataJson

    @csv
    Scenario: Verificar que se puede probar con data de CSV
        Given path karate.get('pathUser')
        When method Get
        Then status 200
        # Esta línea realiza una funcion que convierte el tipo string a numero entero, esto porque karate por default al leer un csv lo convierte a un json pero todos los valores a string, entonces con esta logica se convierte a numero entero los valores necesarios.
        * def dataCsvConverted = karate.map(dataCsv, function(x) { x.id = ~~x.id; return x })
        And match response.data == dataCsvConverted[0]
        * print "data en CSV, ambiente: " + karate.env 
        * print dataCsvConverted

    @schema
    Scenario: Verificar los tipos de datos de un JSON
        Given path karate.get('pathUser')
        When method Get
        Then status 200
        And match response.data == schema_user_json
        * print "data de Schema JSON, ambiente: " + karate.env 
        * print schema_user_json