Feature: Manage phone numbers

  Scenario: create a new phone number
    Given I am on the contact page for "McGee, Tester"
    When I follow "Add Phone Number"
    And I select "Cell" from "Label"
    And I fill in "Phone" with "(123) 456-7890"
    And I press "Create Phone number"
    Then I should be on the contact page for "McGee, Tester"
    When I follow "Cell: +1 123 456 7890"
    Then I should see "Phone Number Revisions (0)"
    
  Scenario: create a new phone number but leave Label blank
    Given I am on the contact page for "McGee, Tester"
    When I follow "Add Phone Number"
    And I fill in "Phone" with "(123) 456-7890"
    And I press "Create Phone number"
    Then I should see "can't be blank" within "li#phone_number_label_input"