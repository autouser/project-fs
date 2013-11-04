Feature: Project Management
  In order to organize projects
  As an user
  I should be able to manage projects

  Background:
    Given I have logged in as an user

  Scenario: List projects
    Given I have projects:
      | Project1 | Project1 Description |
      | Project2 | Project2 Description |
    When I visit projects dasboard
    Then I see my projects

  Scenario: Create project
    When I visit projects dasboard
    And I create a new project with name "Project1" and description "Project1 Description"
    Then I see the project created

  Scenario: Update project
    Given I have projects:
      | Project1 | Project1 Description |
    When I visit projects dasboard
    And I update project "Project1" with name "Project2" and description "Project2 Description"
    Then I see the project updated

  Scenario: Delete project
    Given I have projects:
      | Project1 | Project1 Description |
      | Project2 | Project2 Description |
    When I visit projects dasboard
    And I delete project "Project1"
    Then I see the project deleted