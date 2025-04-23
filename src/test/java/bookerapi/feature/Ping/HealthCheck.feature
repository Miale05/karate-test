@healthcheck
Feature: Obtener el Estado del API

    Background: Definir Background
        Given url karate.get('basePingUrl')
    
    Scenario: Verificar que el API esté en línea
        When method Get
        Then status 201
        And match response == "Created"
    
    Scenario: Verificar que se obtenga error 404 porque no se puede obtener el estado del API con un path
        And path '1'
        When method Get
        Then status 404
        And match response == "Not Found"