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
    @create_new_page = CreateNewPage.new test_run
    @login_page = LoginPage.new test_run
    @object_page = ObjectPage.new test_run
    @person_page = PersonPage.new test_run
    @search_page = SearchPage.new test_run
    @search_results_page = SearchResultsPage.new test_run

    CA = {CorePersonData::NATIONALITY.name => "Canada"}
    US = {CorePersonData::NATIONALITY.name => "United States"}
    WARHOL = {CorePersonData::NATIONALITY.name => "Warholian_test"}
    DISPLAY_NAME = "Test Name " + Time.now.to_i.to_s

    @person_1 = {
      CorePersonData::NATIONALITY.name => [US, CA],
      CorePersonData::PERSON_TERM_GRP.name => [{CorePersonData::TERM_DISPLAY_NAME.name => DISPLAY_NAME}]
    }
    @add_artist = {
      BAMPFAObjectData::ARTIST_MAKER_GRP.name => [{BAMPFAObjectData::ARTIST_NAME.name => DISPLAY_NAME}]
    }
    @warhol = {
      CorePersonData::NATIONALITY.name => [US, WARHOL]
    }
    @warhol_reset = {
      CorePersonData::NATIONALITY.name => [US]
    }
    @object_1 = {
      BAMPFAObjectData::ID_PREFIX.name => Time.now.to_i/15
    }

    @login_page.load_page
    @login_page.log_in(@admin.username, @admin.password)

    @search_page.click_create_new_link
    @create_new_page.click_create_new_object
    @object_page.enter_id_number @object_1
    @object_page.save_record
  end

  after(:all) {
    @object_page.click_sidebar_term("Bailey, Marsha E.")
    @person_page.enter_nationality(@warhol_reset)
    @person_page.save_record
    quit_browser test_run.driver
  }

  it 'add a new Person to an existing object' do
    @search_page.click_create_new_link
    @create_new_page.click_create_new_authority_person_local
    @person_page.create_new_person_authority(@person_1)
    @person_page.quick_search("Objects", [], @object_1[BAMPFAObjectData::ID_PREFIX.name])
    @search_results_page.click_result(@object_1[BAMPFAObjectData::ID_PREFIX.name])
    @object_page.enter_artist_or_maker(@add_artist)
    @object_page.save_record
  end

  it 'search via nationality' do
    ["United States", "Canada"].each do |nationality|
      @object_page.click_search_link
      @search_page.select_record_type_option("Objects")
      @search_page.enter_persons_nationalities([nationality])
      @search_page.click_search_and_wait_for_results(@search_results_page)
      expect(@search_results_page.row_exists? @object_1[BAMPFAObjectData::ID_PREFIX.name]).to be true
      @search_results_page.click_search_link
    end
  end

  it "check adding a Person's nationality propagates to all object records" do
    @search_page.quick_search("Persons", "All", "Andy Warhol")
    @search_results_page.click_result("Warhol, Andy")
    @person_page.enter_nationality @warhol
    section_header = @person_page.element_text(@person_page.section_header_text("Used By"))
    expect(/Used By: 1(7[4-9]|8[0-5])/ === section_header).to be true
    used_records_num = section_header.delete("^0-9").to_i
    @person_page.save_record(Config.long_wait)

    @person_page.click_search_link
    @search_page.select_record_type_option("Objects")
    @search_page.enter_persons_nationalities(["Warholian_test"])
    @search_page.click_search_and_wait_for_results(@search_results_page)
    records_found = @search_results_page.element_text(@search_results_page.records_found_header_text)
    expect(records_found[/(\d+)(?!.*\d)/].to_i).to eql(used_records_num)
  end

  it "check deleting a Person's nationality propagates to all object records" do
    @search_page.quick_search("Persons", "All", "Andy Warhol")
    @search_results_page.click_result("Warhol, Andy")
    @person_page.enter_nationality @warhol_reset
    @person_page.save_record(Config.long_wait)
    @person_page.click_search_link
    @search_page.select_record_type_option("Objects")
    @search_page.enter_persons_nationalities(["Warholian_test"])
    @search_page.click_search_button
    sleep Config.click_wait
    expect(@search_results_page.exists? @search_results_page.no_results_msg).to be true
  end

  it "check that records aren't refreshed if no nationality is added" do
    @search_page.quick_search("Persons", "All", "Marsha E. Bailey")
    @search_results_page.click_result("Bailey, Marsha E.")
    @person_page.expand_sidebar_used_by
    @person_page.click_sidebar_used_by("1995.46.8.48")
    @object_page.when_exists(@object_page.timestamp, Config.short_wait)
    original_time = @object_page.element_text(@object_page.timestamp)
    @person_page.expand_sidebar_terms_used
    @person_page.click_sidebar_term("Bailey, Marsha E.")
    @person_page.save_record
    @person_page.click_sidebar_used_by("1995.46.8.48")
    @object_page.when_exists(@object_page.timestamp, Config.short_wait)
    expect(@object_page.element_text(@object_page.timestamp)).to eql(original_time)
  end

  it "check that records aren't refreshed if nationality is added to related Person record" do
    @object_page.click_sidebar_term("Bailey, Marsha E.")
    @person_page.enter_nationality(@warhol)
    @person_page.save_record
    @person_page.click_sidebar_used_by("1995.46.8.48")
    @object_page.when_exists(@object_page.timestamp, Config.short_wait)
    expect(/Saved (1 minute|([1-5][\d+]|[1-9]) seconds?) ago/ === @object_page.element_text(@object_page.timestamp)).to be true
  end

end
