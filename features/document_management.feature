Feature: Project Management
  In order to keep documents in a project
  As an user
  I should be able to manage documents

  Background:
    Given I have logged in as an user
    And I have projects:
      | Project1 | Project1 Description |
    And I have directories for the project "Project1":
      | parent | name   |
      |        | Dir1   |
      | Dir1   | Dir1.1 |

  @javascript
  Scenario: Upload document
    When I visit the project
    And I choose the directory "Dir1.1"
    And I upload document "test.doc" to the directory
    And I choose the directory "Dir1.1"
    Then I see the document

  Scenario: Delete document
    Given I have document "test.doc" in directory "Dir1.1"
    When I visit the project
    And I choose the directory "Dir1.1"
    And I delete the document "test.doc"
    Then I see no document