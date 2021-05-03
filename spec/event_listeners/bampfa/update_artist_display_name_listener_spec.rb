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
    @search_page = SearchPage.new test_run
    @search_results_page = SearchResultsPage.new test_run
    @person_page = PersonPage.new test_run

    @test_0 = {
      BAMPFAObjectData::ID_PREFIX.name => 0,
      BAMPFAObjectData::ID_YEAR.name => 1,
      BAMPFAObjectData::ID_GIFT_1.name => 2,
      BAMPFAObjectData::ID_GIFT_2.name => 3,
      BAMPFAObjectData::ID_GIFT_3.name => 4,
      BAMPFAObjectData::ID_ALPHA.name => 5
    }

    @test_1 = {
      BAMPFAObjectData::ARTIST_MAKER_GRP.name => [{BAMPFAObjectData::ARTIST_NAME.name => "Sean"}]
    }

    @test_2 = {
      BAMPFAObjectData::ARTIST_MAKER_GRP.name => [{BAMPFAObjectData::ARTIST_NAME.name => "Sean Again"}]
    }

    @test_3 = {
      CorePersonData::PERSON_TERM_GRP.name => [{CorePersonData::NAME_FORENAME.name => "Sean", CorePersonData::NAME_SURNAME.name => "Third"}]
    }

    @test_4 = {
      CorePersonData::PERSON_TERM_GRP.name => [{CorePersonData::NAME_FORENAME.name => "Andy", CorePersonData::NAME_MIDDLE_NAME.name => "John", CorePersonData::NAME_SURNAME.name => "Warhol"}]
    }

    @test_5 = {
      CorePersonData::PERSON_TERM_GRP.name => [{CorePersonData::NAME_FORENAME.name => "Andy", CorePersonData::NAME_MIDDLE_NAME.name => "", CorePersonData::NAME_SURNAME.name => "Warhol"}]
    }


    @login_page.load_page
    @login_page.log_in(@admin.username, @admin.password)

  end

  after(:all) { quit_browser test_run.driver }

  it 'Create a new recod with an artist and searching' do
    @search_page.click_create_new_link
    @create_new_page.click_create_new_object
    @object_page.enter_bampfa_object_id_data @test_0
    @object_page.click_save_button
    @object_page.close_notifications_bar
    @object_page.enter_bampfa_object_id_data @test_1
    @object_page.click_save_button
    @object_page.quick_search('Objects', '', "0.1.2.3.4.5")
    expect(@search_results_page.row_exists? "0.1.2.3.4.5").to be true
    expect(@search_results_page.row_exists? "Sean").to be true
  end

  it 'Create a new record with an artist and searching' do
    @search_results_page.click_result("0.1.2.3.4.5")
    @object_page.enter_bampfa_object_id_data @test_2
    @object_page.click_save_button
    @object_page.click_search_link
    @search_page.select_record_type_option('Objects')
    today = Date.today.to_s
    @search_page.enter_last_updated_times(today, today)
    @search_page.click_search_button
    expect(@search_results_page.row_exists? "0.1.2.3.4.5").to be true
    expect(@search_results_page.row_exists? "Sean Again").to be true
  end

  it 'Update the artist' do
    @search_results_page.click_result("0.1.2.3.4.5")
    @object_page.expand_sidebar_terms_used
    @object_page.click_sidebar_term('Sean Again')
    @person_page.enter_terms @test_3
    @person_page.click_save_button
    @person_page.wait_for_notification 'Saved'
    @person_page.expand_sidebar_used_by
    @person_page.click_sidebar_used_by("0.1.2.3.4.5")
    @object_page.quick_search('Objects', '', "0.1.2.3.4.5")
    expect(@search_results_page.row_exists? "0.1.2.3.4.5").to be true
    expect(@search_results_page.row_exists? "Third, Sean").to be true
  end

  it 'Updating hundreds of records' do
    @search_results_page.quick_search('Persons', '', "Andy Warhol")
    @search_results_page.click_result("Warhol, Andy")
    @person_page.enter_terms @test_4
    @person_page.click_save_button
    @person_page.wait_for_notification('Saved', Config.medium_wait)
    @person_page.expand_sidebar_used_by
    @person_page.click_sidebar_used_by("1")
    # Does not work, need to fix
    # expect(@object_page.title_bar_field_present? "Warhol, Andy John").to be true
    @object_page.click_search_link
    @search_page.enter_keyword('Warhol')
    @search_page.click_search_button
    expect(@search_results_page.row_exists?  "Warhol, Andy John").to be true
  end

  it 'Re-updating hudreds of records' do
    @search_results_page.quick_search('Persons', '', "Andy John Warhol")
    @search_results_page.click_result("Warhol, Andy John")
    @person_page.enter_terms @test_5
    @person_page.click_save_button
    @person_page.wait_for_notification('Saved', Config.medium_wait)
    @person_page.expand_sidebar_used_by
    @person_page.click_sidebar_used_by("1")
    # Does not work, need to fix
    # expect(@object_page.title_bar_field_present? "Warhol, Andy").to be true
    expect(@object_page.title_bar_field_present? "Warhol, Andy John").to be false
    @object_page.click_search_link
    @search_page.enter_keyword('Warhol')
    @search_page.click_search_button
    expect(@search_results_page.row_exists?  "Warhol, Andy").to be true
    expect(@search_results_page.row_exists?  "Warhol, Andy John").to be false
  end
end