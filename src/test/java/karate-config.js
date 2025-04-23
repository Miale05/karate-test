function fn() {
  var env = karate.env; // get system property 'karate.env'
  
  if (!env) {
    env = "dev";
  }

  karate.log("karate.env la propiedad en el sistema es:", env);

  var config = {
    baseUrl: "",
    pathUser: "",
    dataJson: "",
    dataCsv: "",
    schemaUser: karate.read('classpath:bdd/resources/responses/json/schemaUser.json'),
  };

  if (env == "dev") {
    config.baseUrl = "https://reqres.in/api",
    config.pathUser = "users/1"
    config.dataJson = karate.read('classpath:bdd/resources/responses/json/dataUserDev.json'),
    config.dataCsv = karate.read('classpath:bdd/resources/responses/csv/dataUserDev.csv')

  } else if (env == "qa") {
    config.baseUrl = "https://reqres.in/api",
    config.pathUser = "users/2",
    config.dataJson = karate.read('classpath:bdd/resources/responses/json/dataUserCert.json'),
    config.dataCsv = karate.read('classpath:bdd/resources/responses/csv/dataUserCert.csv')

  } else if (env == "prod") {
    config.baseUrl = "https://reqres.in/api",
    config.pathUser = "users/3",
    config.dataJson = karate.read('classpath:bdd/resources/responses/json/dataUserProd.json'),
    config.dataCsv = karate.read('classpath:bdd/resources/responses/csv/dataUserProd.csv')
    
  }

  karate.configure('connectTimeout', 50000);
  karate.configure('readTimeout', 50000);
  karate.configure('logPrettyRequest', true);
  karate.configure('logPrettyResponse', true);
  return config;
}
