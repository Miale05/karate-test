function fn() {
  var env = karate.env; // get system property 'karate.env'
  
  if (!env) {
    env = "qa";
  }

  karate.log("karate.env system property was:", env);

  var config = {
    baseAuthUrl: "https://www.devurl.com/auth",
    baseBookingUrl: "https://www.devurl.com/booking",
    basePingUrl: "https://www.devurl.com/ping",
    tokenUsername: "DEVUSER",
    tokenPassword: "12345",
  };

  if (env == "qa") {
    config.baseAuthUrl = "https://restful-booker.herokuapp.com/auth",
    config.baseBookingUrl = "https://restful-booker.herokuapp.com/booking",
    config.basePingUrl = "https://restful-booker.herokuapp.com/ping",
    config.tokenUsername = "admin",
    config.tokenPassword = "password123"
  } else if (env == "prod") {
    config.baseAuthUrl = "https://www.produrl.com/auth",
    config.baseBookingUrl = "https://www.produrl.com/booking",
    config.basePingUrl = "https://www.produrl.com/ping",
    config.tokenUsername = "PRODUSER",
    config.tokenPassword = "12345"
  }

  karate.configure('connectTimeout', 50000);
  karate.configure('readTimeout', 50000);
  karate.configure('logPrettyRequest', true);
  karate.configure('logPrettyResponse', true);
  return config;
}
