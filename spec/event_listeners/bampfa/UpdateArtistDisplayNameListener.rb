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
    @create_new_page = CoreCreateNewPage test_run
    @login_page = CoreLoginPage test_run
    @object_page = CoreObjectPage test_run
    @search_page = SearchPage test_run
    @search_results_page = SearchResultsPage test_run

    @test_0 = {
      BAMPFAObjectData::ID_PREFIX.name => 0,
      BAMPFAObjectData::ID_YEAR.name => 1,
      BAMPFAObjectData::ID_GIFT_1.name => 2,
      BAMPFAObjectData::ID_GIFT_2.name => 3,
      BAMPFAObjectData::ID_GIFT_3.name => 4,
      BAMPFAObjectData::ID_ALPHA.name => 5,
      BAMPFAObjectData::ARTIST_MAKER_GRP.name => [{BAMPFAObjectData::ARTIST_NAME.name => "Sean"}]
    }

    @test_1 = {
      BAMPFAObjectData::ARTIST_MAKER_GRP.name => [{BAMPFAObjectData::ARTIST_NAME.name => "Sean"}]
    }

    @test_2 = {

    }

    @login_page.load_page
    @login_page.log_in(@admin.username, @admin.password)

  end

  after(:all) { quit_browser test_run.driver }

  it 'Create a new recod with an artist and searching' do
    @search_page.click_create_new_link
    @create_new_page.click_create_new_object
    @object_page.enter_IDs
    @object_page.click_save_button
    @object_page.enter_artist
    @object_page.click_save_button
    @object_page.quick_search('Objects', '', 012345)

  end

  it 'Create a new record with an artist and searching' do
    @search_results_page.click_result()
    @object_page.enter_artist @test_1
    @object_page.click_save_button
    @object_page.click_search_link
    @search_page.select_record_type_option('Objects')
    @search_page.enter_last_updated_times()
    # check if record exist
    @search_results_page.click_result()

end