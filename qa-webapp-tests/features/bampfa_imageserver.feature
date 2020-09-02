Feature: The BAMPFA imageserver application.

Scenario: Find and use the keyword search feature to test the imageserver application.
    Given I am on the "bampfa" homepage
    When I log in to "bampfa"
    Then I click "internal"
    When I enter "glass" in "materials" and click "Grid"
    Then I will click the arrows to toggle between pages
    Then I will click an image with id "e5477fd9-61a1-4474-a9af" and observe url contains imageserver