@getbookingdetail
Feature: Obtener Detalle Reserva

    Background: Definir background
        Given url karate.get('baseBookingUrl')
        And header Accept = 'application/json'
        * path '1'

    Scenario: Verificar que se obtenga los detalles de una reserva en formato JSON
        * def response_get_booking_detail = read('classpath:bookerapi/resources/responses/booking_detail.json')
        When method Get
        Then status 200
        And match response == '#object'
        And match response == response_get_booking_detail

    Scenario Outline: Verificar que exista el atributo <atributo> al obtener los detalles de una reserva en formato XML
        * header Accept = 'application/xml'
        When method Get
        Then status 200
        And match response/booking/<atributo> == '#present'
    
    Examples:
        | atributo |
        | firstname |
        | lastname |
        | totalprice |
        | depositpaid |
        | bookingdates |
        | additionalneeds |
    
    Scenario: Verificar que se obtenga un error 404 al intentar obtener los detalles de una reserva inexistente
        * path '0'
        When method Get
        Then status 404
        And match response == "Not Found"
        

  