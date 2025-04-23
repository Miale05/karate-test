@updatebooking
Feature: Actualizar una Reserva

    Background: Definir background
        Given url karate.get('baseBookingUrl')
        * def Auth = call read('classpath:bookerapi/resources/GenerateToken.feature')
        And header Cookie = 'token=' + Auth.token
        And header Content-Type = 'application/json'
        And header Accept = 'application/json'
        And path '1'
        * def dataGenerator = Java.type('bookerapi.resources.DataGenerator')
        * def randomUsername = dataGenerator.getRandomUsername()
        * def randomLastname = dataGenerator.getRandomLastname()
        * def randomPrice = dataGenerator.getRandomPrice()
        * def randomBoolean = dataGenerator.getRandomBoolean()
        * def randomDate = dataGenerator.getRandomDate()
        * def randomDatePlusOneYear = dataGenerator.addOneYearToDate(randomDate)
        * def randomPokemon = dataGenerator.getRandomPokemon()
        * def response_update_booking = read('classpath:bookerapi/resources/responses/booking_detail.json')
        * def request_update_booking = read('classpath:bookerapi/resources/requests/new_booking.json')
        * def request_xml_update_booking = read('classpath:bookerapi/resources/requests/new_booking.xml')

    Scenario: Verificar que se pueda actualizar una reserva con éxito en formato JSON
        * set request_update_booking.firstname = randomUsername
        * set request_update_booking.lastname = randomLastname
        * set request_update_booking.totalprice = randomPrice
        * set request_update_booking.depositpaid = randomBoolean
        * set request_update_booking.bookingdates.checkin = randomDate
        * set request_update_booking.bookingdates.checkout = randomDatePlusOneYear
        * set request_update_booking.additionalneeds = randomPokemon
        And request request_update_booking
        When method Put
        Then status 200
        And match response == '#object'
        And match response == response_update_booking
        And match response.firstname == randomUsername
        And match response.lastname == randomLastname
        And match response.totalprice == randomPrice
        And match response.depositpaid == randomBoolean
        And match response.bookingdates.checkin == randomDate
        And match response.bookingdates.checkout == randomDatePlusOneYear
        And match response.additionalneeds == randomPokemon
        
    Scenario: Verificar que se pueda actualizar una reserva con éxito en formato XML
        And header Content-Type = 'text/xml'
        And header Accept = 'application/xml'
        * configure charset = null
        And request request_xml_update_booking
        When method Put
        Then status 200
        And match response/booking == request_xml_update_booking
    
    Scenario: Verificar que se pueda actualizar una reserva con éxito en formato URL Encoded
        And header Content-Type = 'application/x-www-form-urlencoded'
        * configure charset = null
        * form field firstname = randomUsername
        * form field lastname = randomLastname
        * form field totalprice = randomPrice
        * form field depositpaid = randomBoolean
        * form field bookingdates[checkin] = randomDate
        * form field bookingdates[checkout] = randomDatePlusOneYear
        When method Put
        Then status 200
        And match response == '#object'
        And match response == response_update_booking
        And match response.firstname == randomUsername
        And match response.lastname == randomLastname
        And match response.totalprice == randomPrice
        And match response.bookingdates.checkin == randomDate
        And match response.bookingdates.checkout == randomDatePlusOneYear

    Scenario: Verificar que se obtenga error 500 porque no se puede actualizar un atributo de una reserva con un valor con diferente tipo de dato
        * set request_update_booking.firstname = 12345
        And request request_update_booking
        When method Put
        Then status 500
        And match response == 'Internal Server Error'
