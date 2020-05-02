function fn() {

  karate.configure('connectTimeout', 500000);
  karate.configure('readTimeout', 500000);
  var env = karate.env|| 'alpha'; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);

  var envData = read('classpath:config/'+env+'/'+env+'-config.json');
  /* If Env is Dev, it should use data of alpha except for the configs */
  if(env == 'dev')
   env = 'alpha';

  var config = {
    env: env,
    serviceBaseURL : ''
  }

  var tokenData ;

  config.baseURL = envData.base_url;
  config.serviceBaseURL = envData.service_base_url;
  config.authURL = envData.auth_url;
  config.authBasic = envData.basic_token;

  var uuid = envData.app_id+'-AUTOMATION-' + java.util.UUID.randomUUID();
  config.transcationID = uuid;

  config.port = karate.callSingle('classpath:start-mock.js');
  config.default_tokens = karate.callSingle('classpath:token-generator.js', config);


  return config;
}