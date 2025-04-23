@deletebooking
Feature: Eliminar una Reserva

    Background: Definir Background
        Given url karate.get('baseBookingUrl')
        And header Content-Type = 'application/json'
        * def Auth = call read('classpath:bookerapi/resources/GenerateToken.feature')
        And header Cookie = 'token=' + Auth.token

    Scenario: Verificar que se pueda eliminar una reserva con éxito
        * def Booking = call read('classpath:bookerapi/resources/GenerateBooking.feature')
        And path Booking.bookingId
        When method Delete
        Then status 201
        And match response == "Created"

    Scenario: Verificar que se obtenga error 404 porque no se puede eliminar una reserva sin un ID
        When method Delete
        Then status 404
        And match response == "Not Found"

    Scenario: Verificar que se obtenga error 405 porque no se puede eliminar una reserva con un ID inexistente
        And path '0'
        When method Delete
        Then status 405
        And match response == "Method Not Allowed"