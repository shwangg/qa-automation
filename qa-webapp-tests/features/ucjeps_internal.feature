Feature: the UCJEPS Portal (Search) application

Scenario: Find and use the keyword search feature
    Given I am on the "ucjeps" homepage
    When I log in to "ucjeps"
    Then I click "search"
    Then I verify the search fields "Scientific Name, Collector(s), Locality (verbatim), County, Cultivated?, Major Group, Date Collected, Associated Taxa, Type Assertions?, Collection Number, Specimen ID, Country" in "div#searchfieldsTarget"

    When I enter "cubensis" in "keyword" and click "List"
    #Then I click on "cubensis" in the dropdown menu and search
    Then I verify the table headers "Specimen ID, Scientific Name, Collector(s) (verbatim), Collection Number, Date Collected, Locality (verbatim), County, State, Country"
    Then I will click the arrows to toggle between pages
    Then I click the button "download selected as csv" and download the csv file

    When I click "Maps"
    Then I verify the maps buttons
    When I click the button "map selected with Google staticmaps API"
    Then I find the content "selected objects in result set examined." in "div#maps"
    When I click the button "map selected with Berkeley Mapper"
    Then "BerkeleyMapper" opens in a new window

    When I click "Statistics"
    Then I will select "Specimen ID" under Select field to summarize on
    Then I find the content "Specimen ID, Count" in "div#statsresults"
    Then I click the button "downloadstats" and download the csv file

    When I click "Facets"
    Then I find the content "Scientific Name, Major Group, Family, Collector(s), County, State, Country" in "div#tabs"
    Then I will click the up and down arrows beside the headers without knowing table name
    Then I will click on a value "Barbella cubensis (Mitt.) Broth." and see it appear in the field "determination"
    Then I will click "Reset" and the "keyword" field should have ""

    When I enter "UC1624979" in "accession" and click "Full"
    Then I will click the arrows to toggle between pages
    Then I click the button "download selected as csv" and download the csv file
    And I verify the contents of the page
    Then I find the content "Current time:" in "div#container"
    When I find the content "About, Help, Credits" in "div#branding"
    When I click "Sign out"
    Then I find the content "eloan, publicsearch, search" in "div#content-main"