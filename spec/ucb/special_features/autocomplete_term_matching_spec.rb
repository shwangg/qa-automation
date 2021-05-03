require_relative '../../../spec_helper'

[Deployment::PAHMA, Deployment::CORE_UCB].each do |deploy|

  test_run = TestConfig.new deploy
  test_id = Time.now.to_i

  person_0 = { CoreAuthorityData::TERM_DISPLAY_NAME.name => "James#{test_id}" }
  person_1 = { CoreAuthorityData::TERM_DISPLAY_NAME.name => "James#{test_id} S" }
  person_2 = { CoreAuthorityData::TERM_DISPLAY_NAME.name => "James#{test_id} Company" }

  org_0 = { CoreAuthorityData::TERM_DISPLAY_NAME.name => "Thermos#{test_id}" }
  org_1 = { CoreAuthorityData::TERM_DISPLAY_NAME.name => "The Thermos#{test_id}" }
  org_2 = { CoreAuthorityData::TERM_DISPLAY_NAME.name => "Asta#{test_id}" }
  org_3 = { CoreAuthorityData::TERM_DISPLAY_NAME.name => "Asta#{test_id} Co" }

  searches = [
    { string: "James#{test_id}*", count: "3" },
    { string: "james#{test_id}*company", count: "1" },
    { string: "company*james#{test_id}*", count: "No" },
    { string: "Thermos#{test_id}*", count: "2" },
    { string: "^Thermos#{test_id}*", count: "1" },
    { string: "Asta#{test_id}*", count: "2" },
    { string: "*Asta#{test_id}^", count: "1" },
    { string: "^Asta#{test_id}^", count: "1" },
    { string: "James#{test_id}*s", count: "1" },
    { string: "James#{test_id}*s^", count: "1" }
  ]

  describe 'CollectionSpace' do

    include Logging
    include WebDriverManager

    before(:all) do
      test_run.set_driver launch_browser
      @admin = test_run.get_admin_user
      @login_page = LoginPage.new test_run
      @search_page = SearchPage.new test_run
      @create_new_page = CreateNewPage.new test_run
      @loan_in_page = LoanInPage.new test_run
      @person_page = PersonPage.new test_run
      @org_page = OrganizationPage.new test_run

      @login_page.load_page
      @login_page.log_in(@admin.username, @admin.password)

      [person_0, person_1, person_2].each do |person|
        @search_page.click_create_new_link
        @create_new_page.click_create_new_authority_person_local
        @person_page.enter_number person
        @person_page.save_record
      end

      [org_0, org_1, org_2, org_3].each do |org|
        @search_page.click_create_new_link
        @create_new_page.click_create_new_org_local
        @org_page.enter_number org
        @org_page.save_record
      end
    end

    after(:all) { quit_browser test_run.driver }

    searches.each do |search|
      it "allows an admin to find a new collection loan in lender name with #{search}" do
        @loan_in_page.click_create_new_link
        @create_new_page.click_create_new_loan_in
        @loan_in_page.wait_for_element_and_type(@loan_in_page.lender_input(0), search[:string])
        @loan_in_page.when_exists(@loan_in_page.term_search_result_msg, Config.short_wait)
        @loan_in_page.wait_until(Config.short_wait, "Expected '#{@loan_in_page.element_text(@loan_in_page.term_search_result_msg)}' to include '#{search[:count]}'") do
          @loan_in_page.element_text(@loan_in_page.term_search_result_msg).include? "#{search[:count]} matching term"
        end
      end
    end
  end
end
