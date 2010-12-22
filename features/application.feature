Feature: Application
  In order to be happy
  As a user
  I want to access my application

  Scenario: Initial application
    Given I am on "the home page"
    When I go to "the home page"
    Then I should see "Unfollower Tracker" within "h1"
