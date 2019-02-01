# qa-automation
CollectionSpace functional QA automation

License: https://opensource.org/licenses/ECL-2.0

## Summary

Automated, UI-driven functional testing for CollectionSpace, supporting multiple deployments (i.e., tenants). The tests are written in RSpec and use Selenium WebDriver to interact with CollectionSpace in a browser.

### Test Design

Pages in the UI are treated as objects in the tests. The objects contain methods for finding elements in the UI and methods for interacting with them.

The tests can support multiple deployments, each with a different version of the CollectionSpace UI. A new deployment can be defined in the deployment model. Page objects representing the distinct UI should be added in the same way as the default Core pages, as subclasses of the generic parent class (see supers in the pages directory). Page elements and interactions that are common to all deployments should be kept in the respective superclass, making them available to all versions of the same page. Dedicated test data files should be added to support the data elements applicable to the deployment. At runtime, the tests will use the deployment configuration in the settings YAML file to determine which UI is under test.

## Setup

The following is specific to Mac OS X.

### Chrome and ChromeDriver
The default browser is Chrome. If you do not have Chrome installed, download and install the [latest version](https://www.google.com/chrome/browser/desktop/index.html).

Download and install the latest version of the ChromeDriver binary from the [ChromeDriver Download page](https://sites.google.com/a/chromium.org/chromedriver/downloads), and add it to your PATH.

### Command line tools

If you do not have Xcode Command Line Tools installed, then download them
```
xcode-select --install
```

### Homebrew

If you do not have Homebrew installed, visit the [Homebrew documenation](https://brew.sh/) and follow the instructions to install. If you have it installed
```
brew update
```

### RVM and Ruby

If you do not have RVM installed, visit the [RVM documentation](https://rvm.io/) and follow the instructions to install. The test suite currently requires ruby-2.3.4.  If you do not have that version
```
rvm install 2.3.4
```
Once installed
```
rvm use 2.3.4
```

### Dependencies

Once you have cloned the repository, make sure you have the bundler gem
```
gem install bundler
```
Then
```
bundle install
```

## Running the Tests

### Config override
To override the default configuration, add an override file at
```
~/.cspace-selenium-config/settings.yml
```

### Test data override
The default test data is intended as example of the format required. To override the default test data with more meaningful data, add an override file at
```
~/.cspace-selenium-config/[deployment code]/[file name of the default]
```
For example:
```
~/.cspace-selenium-config/core/test-data-create-new-object.json
```

### Run tests
```
rake cspace
```

Results of the test run will be written to
```
tmp/test-results
```
Logging output from the test run will be written to
```
tmp/selenium-log
```
