@postbooking
Feature: Crear una Reserva
    
    Background: Definir background
        Given url karate.get('baseBookingUrl')
        And header Content-Type = 'application/json'
        And header Accept = 'application/json'
        * def dataGenerator = Java.type('bookerapi.resources.DataGenerator')
        * def randomUsername = dataGenerator.getRandomUsername()
        * def randomLastname = dataGenerator.getRandomLastname()
        * def randomPrice = dataGenerator.getRandomPrice()
        * def randomBoolean = dataGenerator.getRandomBoolean()
        * def randomDate = dataGenerator.getRandomDate()
        * def randomDatePlusOneYear = dataGenerator.addOneYearToDate(randomDate)
        * def randomPokemon = dataGenerator.getRandomPokemon()
        * def response_created_booking = read('classpath:bookerapi/resources/responses/created_booking.json')
        * def request_create_booking = read('classpath:bookerapi/resources/requests/new_booking.json')
        * def request_xml_create_booking = read('classpath:bookerapi/resources/requests/new_booking.xml')

    Scenario: Verificar que se cree una reserva con éxito en formato JSON
        * set request_create_booking.firstname = randomUsername
        * set request_create_booking.lastname = randomLastname
        * set request_create_booking.totalprice = randomPrice
        * set request_create_booking.depositpaid = randomBoolean
        * set request_create_booking.bookingdates.checkin = randomDate
        * set request_create_booking.bookingdates.checkout = randomDatePlusOneYear
        * set request_create_booking.additionalneeds = randomPokemon
        And request request_create_booking
        When method Post
        Then status 200

    Scenario: Verificar que la reserva ingresada sea igual que la respuesta con la reserva creada
        And request request_create_booking
        When method Post
        Then status 200
        And match response == '#object'
        And match response == response_created_booking
        And match response.booking.firstname == request_create_booking.firstname
        And match response.booking.lastname == request_create_booking.lastname
        And match response.booking.totalprice == request_create_booking.totalprice
        And match response.booking.depositpaid == request_create_booking.depositpaid
        And match response.booking.bookingdates.checkin == request_create_booking.bookingdates.checkin
        And match response.booking.bookingdates.checkout == request_create_booking.bookingdates.checkout
        And match response.booking.additionalneeds == request_create_booking.additionalneeds
    
    Scenario: Crear una reserva con éxito en formato XML
        And header Content-Type = 'text/xml'
        And header Accept = 'application/xml'
        * configure charset = null
        And request request_xml_create_booking
        When method Post
        Then status 200
        And match response/created-booking == '#present'

    Scenario: Crear una reserva con éxito en formato URL Encoded
        And header Content-Type = 'application/x-www-form-urlencoded'
        * configure charset = null
        * form field firstname = randomUsername
        * form field lastname = randomLastname
        * form field totalprice = randomPrice
        * form field depositpaid = randomBoolean
        * form field bookingdates[checkin] = randomDate
        * form field bookingdates[checkout] = randomDatePlusOneYear
        * form field additionalneeds = randomPokemon
        When method Post
        Then status 200
        And match response == '#object'
    
    Scenario: Verificar que se obtenga error 500 porque no se puede crear una reserva con un campo faltante
        And request 
        """
        {  
            "lastname": "Paez", 
            "totalprice": 300, 
            "depositpaid": true, 
            "bookingdates": { 
                "checkin": "2021-01-01", 
                "checkout": "2022-01-01" 
            },
            "additionalneeds": "Almuerzo"
        }
        """
        When method Post
        Then status 500
        And match response == "Internal Server Error"
    
    Scenario: Verificar que se obtenga error 500 porque no se puede crear una reserva sin un body
        When method Post
        Then status 500
        And match response == "Internal Server Error"