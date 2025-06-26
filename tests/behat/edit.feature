@qtype @qtype_crossword
Feature: Test editing a Crossword question
  As a teacher
  In order to be able to update my Crossword question
  I need to edit them

  Background:
    Given the following "users" exist:
      | username |
      | teacher  |
    And the following "courses" exist:
      | fullname | shortname | category |
      | Course 1 | C1        | 0        |
    And the following "course enrolments" exist:
      | user    | course | role           |
      | teacher | C1     | editingteacher |
    And the following "question categories" exist:
      | contextlevel | reference | name           |
      | Course       | C1        | Test questions |
    And the following "questions" exist:
      | questioncategory | qtype     | name          | template |
      | Test questions   | crossword | crossword-001 | normal   |

  Scenario: Edit a Crossword question
    When I am on the "crossword-001" "core_question > edit" page logged in as teacher
    And the following fields match these values:
      | Question name | crossword-001           |
      | Question text | Crossword question text |
    And I set the following fields to these values:
      | Question name |  |
    And I press "id_submitbutton"
    Then I should see "You must supply a value here."
    And I set the following fields to these values:
      | Question name | Edited crossword-001 name |
    And I press "id_submitbutton"
    And I should see "Edited crossword-001 name"

  Scenario: Editing Crossword question will change the accented setting to not accept wrong accent.
    When I am on the "crossword-001" "core_question > edit" page logged in as teacher
    And I set the following fields to these values:
      | Accented letters | strict |
    And I press "id_submitbutton"
    And I choose "Edit question" action for "crossword-001" in the question bank
    Then the following fields match these values:
      | Accented letters | strict |

  @javascript
  Scenario: Editing Crossword question will change the accented setting to accept wrong accent but subtracts points.
    When I am on the "crossword-001" "core_question > edit" page logged in as teacher
    And I set the following fields to these values:
      | Accented letters                         | penalty                                                                     |
      | Grade for answers with incorrect accents | 0.5                                                                         |
      | Quote/apostrophe matching                | Relaxed: all forms of quotes and apostrophes are interchangeable (default). |
      | For any correct response                 | “Correct feedback”                                                          |
      | For any partially correct response       | ‘Partially correct feedback.’                                               |
    And I press "id_submitbutton"
    And I choose "Edit question" action for "crossword-001" in the question bank
    Then the following fields match these values:
      | Accented letters                         | penalty                                                                     |
      | Grade for answers with incorrect accents | 0.5                                                                         |
      | Quote/apostrophe matching                | Relaxed: all forms of quotes and apostrophes are interchangeable (default). |
      | For any correct response                 | "Correct feedback"                                                          |
      | For any partially correct response       | 'Partially correct feedback.'                                               |
    And I click on "Quote/apostrophe matching" "icon"
    And I should see "If the \"Relaxed\" option is enabled"

  Scenario: Editing Crossword question will change the accented setting to accept wrong accent.
    When I am on the "crossword-001" "core_question > edit" page logged in as teacher
    And I set the following fields to these values:
      | Accented letters | ignore |
    And I press "id_submitbutton"
    And I choose "Edit question" action for "crossword-001" in the question bank
    Then the following fields match these values:
      | Accented letters | ignore |
