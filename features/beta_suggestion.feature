Feature: Beta Suggestions
  @active
  Scenario: Make suggestion
    Given I am on the beta suggestions page
    When I fill in "Suggestion" with "Make it Rock!"
    And I fill in "Your email" with "example@gmail.com"
    And I press "Suggest"
    Then I should see "Thanks for the feedback"
    And I should have 1 suggestion
    
  Scenario: Make empty suggestion
  
  Scenario: Make suggestion without email