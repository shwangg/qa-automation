Feature: the BAMPFA Internal portal search form

Scenario: Sign in and verify search form fields
    Given I am on the "bampfa" homepage
    When I log in to "bampfa"
    Then I click "internal"
    Then I verify the search fields "Keyword, Artist, Materials, ID Number, Title, Dimensions, Other Number, Country"

    When I enter "stone" in the "materials" field
    Then I click on "Alabaster, red stones" in the dropdown menu and search
    Then I verify the table headers "ID Number, Artist, Title, Classification, Dimensions"
    Then I will click the arrows to toggle between pages
    Then I click the button "download selected as csv" and download the csv file

    When I click "Statistics"
    Then I will select "ID Number" under Select field to summarize on
    Then I find the content "ID Number, Count" in "div#statsresults"
    Then I click the button "Download Summary as CSV" and download the csv file

    When I click "Facets"
    Then I find the content "Classification, Artist, Country, Dimensions, Date Made" in "div#tabs"
    Then I will click the up and down arrows beside the headers without knowing table name
    Then I will click on a value "Unknown (Unknown)" and see it appear in the field "artistcalc"
    Then I will click "Reset" and the "artistcalc" field should have ""

    When I enter "Azumaji" in "title" and click "Full"
    Then I will click the arrows to toggle between pages
    Then I click the button "download selected as csv" and download the csv file
    And I verify the contents of the page
    Then I find the content "Current time:" in "div#container"
    When I find the content "About, Help, Credits" in "div#branding"

