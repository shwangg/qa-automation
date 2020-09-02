Feature: The UCJEPS imaginator application

Scenario: Test the Imaginator by checking queries made with "Search the Metadata" and "Search for Images".
    Given I am on the "ucjeps" homepage
    When I log in to "ucjeps"
    Then I click "imaginator"
    Then I will enter "Collection des Plantes Alpines" and click "Search the Metadata"
    Then I click "GOD340"
    Then I find the content "Lat / Long, Collector(s), Date Collected, Locality (verbatim), Locality Note, Country, Previous Determinations, Label Header, Cultivated?, Phase, Determination Details, Type Assertions?" in "div#content"
    Then I will enter "Ambroise" and click "Search for Images"
    Then I verify a page only listing images
    Then I open a new window by clicking "GOD362"
    Then I find the content "Lat / Long, Collector(s), Date Collected, Locality (verbatim), Country, Previous Determinations, Label Header, Cultivated?, Phase, Determination Details, Type Assertions?" in "div#content"
    When I click "Sign out"
    Then I find the content "eloan, publicsearch, search" in "div#content-main"