@ignore
Feature: USER Authentication

  Background:
    * url baseURL + authURL
    * string  basic_token = 'Basic '+ authBasic
    * configure headers = { 'Content-Type': 'application/x-www-form-urlencoded' ,  'Authorization' : '#(basic_token)', 'transaction-id':'#(transcationID)'}

  Scenario: get USER auth token

    Given path 'tokens'
    And request 'username='+__arg.username + '&password='+__arg.password + '&grant_type=password'
    When method post
    Then status 200
    * def token = response.access_token



