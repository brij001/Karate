@ignore
Feature: USER Authentication

  Background:
    * def uuid = function(){ return java.util.UUID.randomUUID() + '' }
    * print uuid()

  Scenario: pathMatches('/tokens') && methodIs('post')

    * print '************* IN TOKEN MOCK ***********'
    * def responseStatus = 200
    * def val = 'my_default_auth_token_'+ uuid()
    * def response = { access_token: #(val) , role : 'ADMIN' }

  Scenario: pathMatches('/users/{id}/info') && methodIs('get')

    * print '************* IN USER INFO MOCK ***********'
    * def responseStatus = 200
    * def response = { search_results:{first_name :'abc'}}