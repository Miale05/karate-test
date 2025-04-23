@token
Feature: Obtener Token de Autenticación

  Background: Definir Background
    Given url karate.get('baseAuthUrl')
    * def tokenUsername = karate.get('tokenUsername')
    * def tokenPassword = karate.get('tokenPassword')

  Scenario: Verificar que se obtiene el token de autenticación
    And request { "username": '#(tokenUsername)', "password": '#(tokenPassword)' }
    When method Post
    Then status 200
    * def token = response.token
  
  Scenario: Verificar que se obtiene error porque no se puede obtener un token de autenticación sin credenciales
    And request { "username": "", "password": "" }
    When method Post
    Then status 200
    And match response.reason == "Bad credentials"
  
  Scenario: Verificar que se obtiene error porque no se puede obtener un token de autenticación sin body
    When method Post
    Then status 200
    And match response.reason == "Bad credentials"
  
  Scenario: Verificar que se obtiene error porque no se puede obtener un token de autenticación con credenciales incorrectas
    And request { "username": "abc", "password": "123" }
    When method Post
    Then status 200
    And match response.reason == "Bad credentials"
  
  Scenario: Verificar que se obtiene error porque no se puede obtener un token de autenticación con un path
    And path '1'
    And request { "username": '#(tokenUsername)', "password": '#(tokenPassword)' }
    When method Post
    Then status 404
    And match response == "Not Found"