@getbookingids
Feature: Obtener IDs de las Reservas

    Background: Definir background
        Given url karate.get('baseBookingUrl')

    Scenario: Verificar que se obtenga todos los IDs de las reservas
        When method Get
        Then status 200
        And match response == '#array'
        And match each response..bookingid == '#number'

    Scenario Outline: Verificar que se obtenga los IDs de las reservas por filtro: <filtro1> <filtro2> <filtro3> <filtro4>
        * if ('<firstname>' != '') karate.set('param.firstname', '<firstname>')
        * if ('<lastname>' != '') karate.set('param.lastname', '<lastname>')
        * if ('<checkin>' != '') karate.set('param.checkin', '<checkin>')
        * if ('<checkout>' != '') karate.set('param.checkout', '<checkout>')
        When method Get
        Then status 200
        And match response == '#array'
        And match each response..bookingid == '#number'

        Examples:
            | filtro1   | filtro2   | filtro3   | filtro4   | firstname  | lastname   | checkin    | checkout   |
            | firstname | lastname | checkin  | checkout | John      | Smith      | 2017-01-01 | 2020-01-02 |
            | firstname | lastname | checkin  |          | John      | Smith      | 2017-01-01 |            |
            | firstname | lastname |          | checkout | John      | Smith      |            | 2020-01-02 |
            | firstname |          | checkin  | checkout | John      |            | 2017-01-01 | 2020-01-02 |
            |          | lastname | checkin  | checkout |           | Smith      | 2017-01-01 | 2020-01-02 |
            | firstname | lastname |          |          | John      | Smith      |            |            |
            |          |          | checkin  | checkout |           |            | 2017-01-01 | 2020-01-02 |
            | firstname |          |          | checkout | John      |            |            | 2020-01-02 |
            |          | lastname | checkin  |          |           | Smith      | 2017-01-01 |            |
            | firstname |          |          |          | John      |            |            |            |
            |          | lastname |          |          |           | Smith      |            |            |
            |          |          | checkin  |          |           |            | 2017-01-01 |            |
            |          |          |          | checkout |           |            |            | 2020-01-02 |

    
    Scenario: Verificar que se obtenga un error 500 Internal Server Error por Date vacio
        And param checkin = ''
        When method Get
        Then status 500
        And match response == '#string'
        And match response == 'Internal Server Error'