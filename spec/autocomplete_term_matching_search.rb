require_relative '../spec_helper'

test_run = TestConfig.new
test_data = test_run.create_autocomplete_term_matching_search_test_data


# READ BEFORE RUN
# known set of sample Person and Organization records needs to be created before running this test:
# Local Persons: "James", "James S", "James Company"
# Local Organization: "Thermos", "The Thermos", "Asta", "Asta Co"

ver = [ 3, # "James*"
        1, # "james*company"
        0, # "company*james*"
        2, # "Thermos*"
        1, # "^Thermos*"
        2, # "Asta*"
        1, # "*Asta^"
        1, # "^Asta^"
        1, # "James*s"
        1] # "James*s^"
i = -1
ret = -1


describe 'CollectionSpace' do

  include Logging
  include WebDriverManager
  include Page
  include CollectionSpacePages

  # def found_0; {:xpath => '//span[contains(.,"No matching terms found")]'} end
  # def found_1; {:xpath => '//span[contains(.,"1 matching term found")]'} end
  # def found_2; {:xpath => '//span[contains(.,"2 matching terms found")]'} end
  # def found_3; {:xpath => '//span[contains(.,"3 matching terms found")]'} end

  before(:all) do
    test_run = TestConfig.new
    test_run.set_driver launch_browser
    @admin = test_run.get_admin_user
    @login_page = test_run.get_page CoreLoginPage
    @search_page = test_run.get_page CoreSearchPage
    @create_new_page = test_run.get_page CoreCreateNewPage
    @loan_in_page = test_run.get_page CoreLoanInPage
    @login_page.load_page
    @login_page.log_in(@admin.username, @admin.password)
    @search_page.click_create_new_link
    @create_new_page.click_create_new_loan_in
  end

    after(:all) { quit_browser test_run.driver }
    
    test_data.each do |test|
        it "allows an admin to create a new collection loan in with #{test}" do
            # begin
                data_input_errors = @loan_in_page.create_new_loan_in test
                i+=1
                expect(data_input_errors).to be ver[i]
                # print(data_input_errors)
            # rescue Selenium::WebDriver::Error::TimeoutError
            #     sleep 1
            #     if exists? found_0
            #       ret = 0
            #       print('got it')
            #     elsif exists? found_1
            #       ret = 1
            #     elsif exists? found_2
            #       ret = 2
            #     elsif exists? found_3
            #       ret = 3
            #       print('got it')
            #     else
            #       ret = -1
            #     end
            #     print(ret)
            #     expect(ret).to be ver[i]
            #     i+=1
            #     @loan_in_page.refresh_page
            # end
        end
    end
end
