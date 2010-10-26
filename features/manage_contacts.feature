Feature: Manage contacts

  Scenario: create a new contact
    Given I am on the contacts page
    When I follow "Create New Contact"
    And I fill in "First name" with "Testee"
    And I fill in "Last name" with "McGoo"
    And I press "Create Contact"
    Then I should see "Contact McGoo, Testee created."
    And I should see "Contact Revisions (0)"

  @wip
  Scenario: edit a contact
    Given I am on the contacts page
    When I follow "edit" within "table.nice_table>tbody>tr:first-child"
    And I fill in "Title" with "Manager"
    And I fill in "Website" with "test.com"
    And I fill in "City" with "Sheboygan"
    And I press "Update Contact"
    Then I should see "Contact McGee, Tester (Manager); Sheboygan updated."
    And I should see "Contact Revisions (1)"
    
  Scenario: delete a contact
    Given I am on the contacts page
    When I follow "delete" within "table.nice_table>tbody>tr:first-child"
    Then I should see "Contact McGee, Tester deleted."

  Scenario: restore a deleted contact
    Given I am on the contacts page
    When I follow "delete" within "table.nice_table>tbody>tr:first-child"
    Then I should see "Contact McGee, Tester deleted."
    When I go to the contact revisions page
    And I follow "restore" within "table.nice_table>tbody>tr:first-child"
    Then I should see "Contact McGee, Tester restored."