Feature: BAMPFA landing page

Scenario: Checks that the landing page has the correct apps displayed when User signs in and signs out
    Given I am on the "bampfa" homepage
    Then I find the content "Applications Available" in "div#header"
    Then I find no link with text "grouper"
    Then I find a link with text "imagebrowser"
    Then I find a link with text "imaginator"
    Then I find no link with text "internal"
    Then I find no link with text "ireports"
    Then I find a link with text "search"
    Then I find no link with text "toolbox"
    Then I find the content "to view all available applications" in "div#content"

    When I click "Sign in"
    Then I find the content "Sign in to the CollectionSpace Webapps using the same login and password you use to login to the CollectionSpace system itself." in "div#login"
    Then I find the content "Or, if you want to see what is available without signing in, click" in "div#login"

    When I sign in to "bampfa"
    Then I find a link with text "grouper"
    Then I find a link with text "imagebrowser"
    Then I find a link with text "imaginator"
    Then I find a link with text "internal"
    Then I find a link with text "ireports"
    Then I find a link with text "search"
    Then I find a link with text "toolbox"

    When I click "Sign out"
    Then I find no link with text "grouper"
    Then I find a link with text "imagebrowser"
    Then I find a link with text "imaginator"
    Then I find no link with text "internal"
    Then I find no link with text "ireports"
    Then I find a link with text "search"
    Then I find no link with text "toolbox"
