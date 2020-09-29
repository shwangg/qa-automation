Feature: The PAHMA ireports feature

Scenario: Navigate the ireports feature, select a report, enter a query, and check the report, reset, and back buttons.
    Given I am on the "pahma" homepage
    When I log in to "pahma"
    Then I click "ireports"
    Then I click "HSR Phase I Inventory"
    When I enter "Kroeber, 20A, AA  1,  9" in "Start Location" and click the report button
    Then I will see the correct report in pdf format
    Then I will click reset and the "Start Location" field should have "Kroeber, 20A, AA  1,  1"
    When I click the back button
    Then I find the content "Component Check, Component Check Subreport, Government Holdings, HSR Phase I Inventory, HSR/Arch. Systematic Inventory, Key Information Review, Systematic Inventory" in "div#content"
	Then I find the content "ComponentCheck.jrxml, ComponentCheckSubReport.jrxml, govholdings.jrxml, HsrPhaseOneInventory.jrxml, SystematicInventoryHSR.jrxml, keyinfobyloc.jrxml, SystematicInventory.jrxml" in "div#content"
    Then I will sign out
    Then I find the content "search" in "div#content-main"
