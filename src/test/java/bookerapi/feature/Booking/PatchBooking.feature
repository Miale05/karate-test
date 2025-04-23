@patchbooking
Feature: Actualizar Parcialmente una Reserva

    Background: Definir background
        Given url karate.get('baseBookingUrl')
        And header Content-Type = 'application/json'
        And header Accept = 'application/json'
        And path '1'
        * def Auth = call read('classpath:bookerapi/resources/GenerateToken.feature')
        And header Cookie = 'token=' + Auth.token
        * def response_patch_booking = read('classpath:bookerapi/resources/responses/booking_detail.json')
        
    
    Scenario Outline: Verificar que se pueda actualizar solo el atributo <atributo> en una reserva con éxito en formato JSON
        * def jsonPatch = { "<atributo>": <valor> }
        And request jsonPatch
        When method Patch
        Then status 200
        And match response == '#object'
        And match response == response_patch_booking
        And match response.<atributo> == <valor>

        Examples:
            | atributo              | valor      |
            | firstname              | "Juan"     |
            | lastname              | "Perez"    |
            | totalprice            | 200        |
            | depositpaid           | true       |
            | additionalneeds       | "Desayuno" |

    Scenario: Verificar que se pueda actualizar el objeto bookingdates en una reserva con éxito en formato JSON
        * def jsonPatch = { "bookingdates": { "checkin": "2021-01-01", "checkout": "2022-01-01" } }
        And request jsonPatch
        When method Patch
        Then status 200
        And match response == '#object'
        And match response == response_patch_booking
        And match response.bookingdates.checkin == "2021-01-01"
        And match response.bookingdates.checkout == "2022-01-01"

    Scenario Outline: Verificar que se pueda actualizar solo el atributo <atributo> en una reserva con éxito en formato XML
        And header Content-Type = 'text/xml'
        And header Accept = 'application/xml'
        * configure charset = null
        * def xmlPatch = 
        """
        <booking>
            <<atributo>><valor></<atributo>>
        </booking>
        """
        And request xmlPatch
        When method Patch
        Then status 200
        And match response/booking == '#present'
        And karate.match('response/booking/<atributo>', 'xmlPatch/booking/<atributo>')

        Examples:
            | atributo              | valor      |
            | firstname              | Mario      |
            | lastname              | Paez       |
            | totalprice            | 300        |
            | depositpaid           | true       |
            | additionalneeds       | Almuerzo   |

    Scenario: Verificar que se pueda actualizar el objeto bookingdates en una reserva con éxito en formato XML
        And header Content-Type = 'text/xml'
        And header Accept = 'application/xml'
        * configure charset = null
        * def xmlPatch = 
        """
        <booking>
            <bookingdates>
                <checkin>2021-01-01</checkin>
                <checkout>2022-01-01</checkout>
            </bookingdates>
        </booking>
        """
        And request xmlPatch
        When method Patch
        Then status 200
        And match response/booking == '#present'
        And karate.match('response/booking/bookingdates/checkin', 'xmlPatch/booking/bookingdates/checkin')
        And karate.match('response/booking/bookingdates/checkout', 'xmlPatch/booking/bookingdates/checkout')

    Scenario Outline: Verificar que se pueda actualizar solo el atributo <atributo> en una reserva con éxito en formato URL Encoded
        And header Content-Type = 'application/x-www-form-urlencoded'
        * configure charset = null
        * form field <atributo> = <valor>
        When method Patch
        Then status 200
        And match response == '#object'
        And match response.<atributo> == <valor>

        Examples:
            | atributo              | valor      |
            | firstname              | "Luis"     |
            | lastname              | "Musk"     |
            | totalprice            | 100        |
            | depositpaid           | true       |
            | additionalneeds       | "Cena"     |