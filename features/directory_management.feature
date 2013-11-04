Feature: Project Management
  In order to keep documents in a project
  As an user
  I should be able to manage directories

  Background:
    Given I have logged in as an user
    And I have projects:
      | Project1 | Project1 Description |
    And I have directories for the project "Project1":
      | parent | name   |
      |        | Dir1   |
      | Dir1   | Dir1.1 |
      | Dir1   | Dir1.2 |
      |        | Dir2   |

  Scenario: Directory tree
    When I visit the project
    Then I see the directory tree

  Scenario: Show directory
    When I visit the project
    And I choose the directory "Dir1.1"
    Then I see the directory

  Scenario: Add root directory
    When I visit the project
    And I add a root directory "New Directory"
    Then I see the directory

  Scenario: Add subdirectory
    When I visit the project
    And I choose the directory "Dir1.1"
    And I add subdirectory "New Directory"
    Then I see the directory

  Scenario: Update directory
    When I visit the project
    And I choose the directory "Dir1.1"
    And I update the directory with name "Updated Directory"
    Then I see the directory

  Scenario: Delete directory
    When I visit the project
    And I choose the directory "Dir1"
    And I delete the directory
    Then I see no directory with name "Dir1"
    Then I see no directory with name "Dir1.1"
    Then I see no directory with name "Dir1.2"