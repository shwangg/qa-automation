# qa-automation
CollectionSpace functional QA automation

License: https://opensource.org/licenses/ECL-2.0

## Summary

Automated, UI-driven functional testing for CollectionSpace, supporting multiple deployments (i.e., tenants). The tests are written in RSpec and use Selenium WebDriver to interact with CollectionSpace in a browser.

### Test Design

Pages in the UI are treated as objects in the tests. The objects contain methods for finding elements in the UI and methods for interacting with them.

The tests can support multiple deployments, each with a different version of the CollectionSpace UI. A new deployment can be defined in the deployment model. Page objects representing the distinct UI should be added as subclasses of the default Core pages. Dedicated test data files should be added to support the data elements applicable to the deployment. At runtime, the tests will use the deployment configuration in the settings YAML file to determine which UI is under test.

## Setup

#### Chrome and ChromeDriver
The default browser is Chrome. If you do not have Chrome installed, download and install the [latest version](https://www.google.com/chrome/browser/desktop/index.html).

Download and install the latest version of the ChromeDriver binary from the [ChromeDriver Download page](https://sites.google.com/a/chromium.org/chromedriver/downloads), and add it to your PATH.

Note: Your Chrome version must match your ChromeDriver version. If these versions ever differ, the tests won't run and you will have to update one or the other.

### <ins>Mac OS X</ins>

The following is specific to Mac OS X.

#### Command line tools

If you do not have Xcode Command Line Tools installed, then download them
```
xcode-select --install
```

#### Homebrew

If you do not have Homebrew installed, visit the [Homebrew documenation](https://brew.sh/) and follow the instructions to install. If you have it installed
```
brew update
```

#### RVM and Ruby

If you do not have RVM installed, visit the [RVM documentation](https://rvm.io/) and follow the instructions to install. The test suite currently requires ruby-2.6.3.  If you do not have that version
```
rvm install 2.6.3
```
Once installed
```
rvm use 2.6.3
```

#### Dependencies

Once you have cloned the repository, `cd` into it and make sure you have the bundler gem
```
gem install bundler
```
Then
```
bundle install
```

### <ins>Windows 10</ins>
The following is specific to Windows 10.

#### Bash
If you do not have a bash shell installed, you must download and install it. Read [here](https://itsfoss.com/install-bash-on-windows/) for more info.

#### RVM and Ruby
Currently, it is very difficult to get RVM to work nicely with Windows. As of now, it is reccomended to follow the installation instructions for installing ruby 2.6.6 from [here](https://rubyinstaller.org/), unless you require another version of ruby elsewhere. 

When prompted to download `msys2`, make sure that you select the option to add ruby to the `PATH`. When asked what components of `msys2` to download, select all: `1, 2, 3`.

Once installed, you can check ruby was successfully installed  by running 
```
ruby  --version
```

#### Dependencies

Once you have cloned the repository, `cd` into it and install the `ffi` gem by running
```
gem install ffi
```

and also make sure you have the bundler gem
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

To run the entire test suite, run
```
rake cspace
```

To run a single test, run
```
rspec ${path/to/test_file.rb}
```

Results of the test run will be written to
```
tmp/test-results
```
Logging output from the test run will be written to
```
tmp/selenium-log
```
