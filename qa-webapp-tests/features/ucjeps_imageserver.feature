Feature: The UCJEPS imageserver application.

Scenario: Find and use the keyword search feature to test the imageserver application.
    Given I am on the "ucjeps" homepage
    When I log in to "ucjeps"
    Then I click "search"
    When I enter "cubensis" in "keyword" and click "Grid"
    Then I will click an image with id "972d18bc-543f-442d-a643" and observe url contains imageserver