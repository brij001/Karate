function tokenGenerator(config){
 var env = config.env;
 var tokenData = read('classpath:config/'+env+'/'+env+'-tokens.json');
 var generatedTokens = {}

// Here we are putting token in config object along with role, user_id and company_id
 if(tokenData.test_token_users != null){
    for(var i=0; i< tokenData.test_token_users.length;i++){
        result = null;

        config.username = tokenData.test_token_users[i].user_name;
        config.password = tokenData.test_token_users[i].password;
        result = karate.call('classpath:auth/user-token.feature', config);
        generatedTokens[tokenData.test_token_users[i].role] = {'token'   :  result.token  };
      }
      config.username = null;
      config.password = null;
    }


    karate.log('Generated Default Tokens :', karate.toJson(generatedTokens));
  return generatedTokens;
}