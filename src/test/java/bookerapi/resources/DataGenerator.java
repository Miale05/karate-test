package bookerapi.resources;

import com.github.javafaker.Faker;

public class DataGenerator {
    
    public static String getRandomEmail() {
        Faker faker = new Faker();
        String email = faker.name().firstName().toLowerCase() + faker.random().nextInt(0, 100) + "@test.com";
        return email;
    }

    public static String getRandomUsername() {
        Faker faker = new Faker();
        String username = faker.name().firstName();
        return username;
    }

    public static String getRandomLastname() {
        Faker faker = new Faker();
        String lastname = faker.name().lastName();
        return lastname;
    }

    public static Integer getRandomPrice() {
        Faker faker = new Faker();
        Integer price = faker.number().numberBetween(100, 999);
        return price;
    }

    public static String getRandomDate() {
        Faker faker = new Faker();
        return faker.date().birthday().toInstant().atZone(java.time.ZoneId.systemDefault()).toLocalDate().toString();
    }

    public static String addOneYearToDate(String date) {
        java.time.LocalDate localDate = java.time.LocalDate.parse(date);
        java.time.LocalDate newDate = localDate.plusYears(1);
        return newDate.toString();
    }

    public static boolean getRandomBoolean() {
        Faker faker = new Faker();
        return faker.random().nextBoolean();
    }

    public static String getRandomPokemon() {
        Faker faker = new Faker();
        String pokemonName = faker.pokemon().name();
        return pokemonName;
    }

}