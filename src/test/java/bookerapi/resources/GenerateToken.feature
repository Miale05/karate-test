Feature: Obtener Token de Autenticación

  Scenario: Obtener Token de Autenticación
    Given url karate.get('baseAuthUrl')
    * def tokenUsername = karate.get('tokenUsername')
    * def tokenPassword = karate.get('tokenPassword')
    And request { "username": '#(tokenUsername)', "password": '#(tokenPassword)' }
    When method Post
    Then status 200
    * def token = response.token