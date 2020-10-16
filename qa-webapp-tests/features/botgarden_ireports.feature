Feature: The Botgarden ireports feature

Scenario: Navigate the ireports feature, select a report, enter a query, and check the report, reset, and back buttons.
    Given I am on the "botgarden" homepage
    When I log in to "botgarden"
    Then I click "ireports"
    Then I click "Rare Status (Family)"
    When I enter "%RUBIACEAE%" in "id_family" and click "report"
    Then I will see the correct report in pdf format
    Then I will click "reset" and the "id_family" field should have "%ARAUCARIACEAE%"
    When I click the back button
    Then I find the content "Accession Count, Dead Report, Deads in Bed, Duplicate Accession Numbers, Label Orders, List of Living Accessions, Rare Status (Family), Rare Status (Genus), Taxon Count, Voucher Family, Voucher Genus, Voucher Label" in "div#content"
    Then I find the content "ucbgAccessionCount.jrxml, ucbgDeadReportRange.jrxml, ucbgDiedInLocation.jrxml, duplicateobjectnumber.jrxml, ucbgLabelOrder.jrxml, ucbgListofLivingAccessions.jrxml, ucbgRareStatusFamily.jrxml, ucbgRareStatusGenus.jrxml, ucbgTaxonCount.jrxml, ucbgVoucherFamily.jrxml, ucbgVoucherGenus.jrxml, ucbgVoucherLabel.jrxml" in "div#content"
