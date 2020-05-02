@regression
Feature: UserInfo Feature

  Background:

    * def data = read('classpath:features/users/user-info.json')[env]
    * params { status: 1, user_type:  #(data.request_data.user_type) }
    * configure headers = { 'Content-Type': 'application/json' }
    * def user_token = callonce read('classpath:auth/user-token.feature') {username:'myusername', password:'myuserpass'}
    * print 'On_the_fly_token : ', user_token.token

    * def myurl = env == 'alpha' ? 'http://localhost:' + port : serviceBaseURL
    * url myurl


  Scenario Outline: Testing UserInfo API with Token <name>
    Given path 'users', data.request_data.user_id,'info'
    And header Authorization = 'Bearer '+ <tokens>
    When method get
    Then status 200
    * print 'Running Test for Token : ',<name>
    And match response.search_results.first_name contains data.response_data.search_data.first_name
    Examples:
      | name   | tokens |
      | 'ADMIN'  | default_tokens.admin.token   |
      | 'USER_TOKEN'  | user_token.token   |
