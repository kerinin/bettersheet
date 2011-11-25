Feature: Beta Invites
  @active
  Scenario: Sign up for invite from the beta sign-up page
    Given I am on the beta sign-up page
    When I fill in "Email" with "example@gmail.com"
    And I press "Sign me up!"
    Then I should see "We'll send you an invitation soon!"
    And "example@gmail.com" should receive an email with subject "Thanks for registering with BetterSheet!"

    When I open the email
    Then I should see "Thanks for signing up" in the email body
  
  @active
  Scenario: Send invite to someone else
    Given I am on the beta recommendation page
    And I fill in "Your name" with "Alice"
    And I fill in "Email you want to recommend" with "example@gmail.com"
    And I press "Recommend"
    Then I should see "We've sent an email to example@gmail.com"
    And "example@gmail.com" should receive an email with subject "Alice invited you to try out BetterSheet; cost management that's better than spreadsheets"
  
  
  @active
  Scenario: Sign up for invite without email
    Given I am on the beta sign-up page
    When I press "Sign me up!"
    Then I should see "You didn't enter an email address"
    And they should receive no emails
  
  @active
  Scenario: Send recommendation without email
    Given I am on the beta recommendation page
    When I fill in "Your name" with "Alice"
    And I press "Recommend"
    Then I should see "You didn't enter an email address" 
    And they should receive no emails
  
  @active
  Scenario: Send recommendation without referrer
    Given I am on the beta recommendation page
    When I fill in "Email you want to recommend" with "example@gmail.com"
    And I press "Recommend"
    Then I should see "You didn't enter your name"
    And they should receive no emails