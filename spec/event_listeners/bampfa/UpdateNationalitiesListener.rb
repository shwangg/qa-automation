require_relative '../../../spec_helper'
deploy = Deployment::BAMPFA

describe 'BAMPFA' do

  include Logging
  include WebDriverManager

  test_run = TestConfig.new deploy
  test_id = Time.now.to_i

  before(:all) do
    test_run.set_driver launch_browser

    @admin = test_run.get_admin_user
    @create_new_page = test_run.get_page CoreCreateNewPage
    @login_page = test_run.get_page CoreLoginPage
    @object_page = test_run.get_page CoreObjectPage
    @person_page = test_run.get_page CorePersonPage
    @search_page = test_run.get_page CoreSearchPage
    @search_results_page = test_run.get_page CoreSearchResultsPage

    @login_page.load_page
    @login_page.log_in(@admin.username, @admin.password)

    ##Create Object record to use in test 1
    @object_1 = {
      BAMPFAObjectData::ID_PREFIX.name => (Time.now.to_i)/15
    }
    @object_2 = {
      BAMPFAObjectData::ID_PREFIX.name => (Time.now.to_i)/50
    }
    [@object_1, @object_2]. each do |record|
      @search_page.click_create_new_link
      @create_new_page.click_create_new_object
      @object_page.enter_id_number @object_1
      @object_page.save_record
    end

  end


  US = {CorePersonData::NATIONALITY.name => "United States"}
  CA = {CorePersonData::NATIONALITY.name => "Canada"}
  display_name = "Test Taxon "+Time.now.to_i.to_s
  person_1 = {
    CorePersonData::NATIONALITY.name => [US, CA],
    CorePersonData::PERSON_TERM_GRP.name => [{CorePersonData::TERM_DISPLAY_NAME.name => display_name}]
  }
  WARHOL = {CorePersonData::NATIONALITY.name => "Warholian_test"}
  warhol = {
    CorePersonData::NATIONALITY.name => [US, WARHOL]
  }
  warhol_reset = {
    CorePersonData::NATIONALITY.name => [US]
  }
  time_stamp = {:xpath => '//div[@class = "cspace-ui-RecordHistory--common"]//button//span'}

  after(:all) { quit_browser test_run.driver }


    it 'Add a new Person to an existing object' do
      @search_page.click_create_new_link
      @create_new_page.click_create_new_authority_person_local
      ##TODO: create one command in person page for below:
      @person_page.enter_terms person_1
      @person_page.enter_nationality person_1
      ##
      @person_page.save_record

      ##SECOND section
      @person_page.quick_search("Objects", [], @object_1[BAMPFAObjectData::ID_PREFIX.name])
      @search_results_page.click_result(@object_1[BAMPFAObjectData::ID_PREFIX.name])
      add_artist = {BAMPFAObjectData::ARTIST_MAKER_GRP.name => [{BAMPFAObjectData::ARTIST_NAME.name => display_name}]}
      @object_page.enter_artist_or_maker(add_artist)
      @object_page.save_record

    end

    it 'Search via Nationality' do
      @person_page.click_search_link
      ["United States", "Canada"].each do |nationality|
        puts nationality
        @search_page.select_record_type_option("Objects")
        @search_page.enter_nationalities([nationality])
        @search_page.click_search_button

        @search_results_page.wait_for_results
        expect(@search_results_page.row_exists? @object_1[BAMPFAObjectData::ID_PREFIX.name]).to be true
        @search_results_page.click_search_link
      end
    end

    it "Check changing a Person's nationality propagates to all object records" do
      #  @search_page.quick_search("Persons", "All", "Warhol Test") #"Andy Warhol"
      @search_page.quick_search("Persons", "All", "Andy Warhol")
      #@search_results_page.click_result("Warhol Test") #"Warhol, Andy"
      @search_results_page.click_result("Warhol, Andy")
      @person_page.enter_nationality warhol

      section_header = @person_page.element_text(@person_page.section_header_text("Used By"))

      ##FOR WARHOL TEST
      #expect(/Used By: 1/ === section_header).to be true
      ##FOR ACTUAL TEST
      expect(/Used By: 1(7[4-9]|8[0-5])/ === section_header).to be true
      used_records_num = section_header.delete("^0-9").to_i
      #save record: have to enable wait to account for loading time for all records update
      @person_page.click_save_button
      @person_page.when_enabled(@person_page.save_button, Config.long_wait)

      @person_page.click_search_link

      @search_page.select_record_type_option("Objects")
      @search_page.enter_nationalities(["Warholian_test"])
      @search_page.click_search_button
      @search_results_page.wait_for_results
      records_found = @search_results_page.element_text(@search_results_page.records_found_header_text)

      expect(/1–[1-9](\d*) of #{records_found}|#{records_found}/ === records_found).to be true
      puts records_found[/(\d+)(?!.*\d)/]
      expect(records_found[/(\d+)(?!.*\d)/].to_i).to eql(used_records_num)

      #  @search_results_page.quick_search("Persons", "All", "Warhol Test") #"Andy Warhol"
      @search_page.quick_search("Persons", "All", "Andy Warhol")
      #@search_results_page.click_result("Warhol Test") #
      @search_results_page.click_result("Warhol, Andy")

      @person_page.enter_nationality warhol_reset

      @person_page.click_save_button
      @person_page.when_enabled(@person_page.save_button, Config.long_wait)

      @person_page.click_search_link
      @search_page.select_record_type_option("Objects")
      @search_page.enter_nationalities(["Warholian_test"])
      @search_page.click_search_button
      sleep Config.click_wait
      expect(@search_results_page.exists? @search_results_page.no_results_msg).to be true
    end

  #need to change previous test from Warhol Test to Andy Warhol record
  it "Check that records aren't refreshed if no nationality is added" do
    ##test using existing records
    @search_page.quick_search("Persons", "All", "Marsha E. Bailey")
    @search_results_page.click_result("Bailey, Marsha E.")
    @person_page.expand_sidebar_used_by
    @person_page.click_sidebar_used_by("1995.46.8.48")
    original_time = @object_page.element_text(time_stamp)

    @person_page.expand_sidebar_terms_used
    @person_page.click_sidebar_term("Bailey, Marsha E.")
    @person_page.save_record
    @person_page.click_sidebar_used_by("1995.46.8.48")
    puts @object_page.element_text(time_stamp)
    puts original_time
    expect(@object_page.element_text(time_stamp)).to eql(original_time)

    ##action
    @object_page.click_sidebar_term("Bailey, Marsha E.")
    @person_page.enter_nationality(warhol)
    @person_page.save_record
    @person_page.click_sidebar_used_by("1995.46.8.48")

    @object_page.when_exists(time_stamp, Config.short_wait)
    puts @object_page.element_text(time_stamp)
    expect(/Saved (1 minute|([1-5][\d+]|[1-9]) seconds) ago/ === @object_page.element_text(time_stamp))

    #reset record for future tests
    @object_page.click_sidebar_term("Bailey, Marsha E.")
    @person_page.enter_nationality(warhol_reset)
    @person_page.save_record
  end
end
