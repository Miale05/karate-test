Feature: Crear una Reserva y Almacenar su ID

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
        * def request_create_booking = read('classpath:bookerapi/resources/requests/new_booking.json')

    Scenario: Crear una Reserva y Almacenar su ID
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
        * def bookingId = response.bookingid
        