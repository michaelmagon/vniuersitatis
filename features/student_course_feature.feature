
Feature: Student Courses Feature
  Scenario: Log in
    Given I am logged in as a "student"
    Then I should be redirected to Course lists

  Scenario: Filter Course List
    Given I am at the home screen
    When I click on Currently Running Courses Filter
    Then I should be redirected to Course lists
    And I should see courses

  Scenario: Viewing Course
    Given I am at the home screen
    When I click on a course
    Then I should be redirected to Course

  Scenario: Applying Course
    Given I am viewing an "upcoming" Course
    When I click on Join Course
    Then I should be notified
    
  Scenario: Viewing My Courses as a student
    Given I am at the home screen
    When I click on My Courses
    Then I should be redirected to My Courses
    And I should see courses
    And I should not see Create course button

