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
    @search_page = test_run.get_page CoreSearchPage

    @test_0 = {
      BAMPFAObjectData::ACC_NUM_PREF.name => 0,
      BAMPFAObjectData::ACC_NUM_P1.name => 1,
      BAMPFAObjectData::ACC_NUM_P2.name => 2,
      BAMPFAObjectData::ACC_NUM_P3.name => 3,
      BAMPFAObjectData::ACC_NUM_P4.name => 4,
      BAMPFAObjectData::ACC_NUM_P5.name => 5
    }

    @test_1 = {
      BAMPFAObjectData::ARTIST.name => [{BAMPFAObjectData::ARTIST_NAME.name => "Sean"}]
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
    @object_page.e
  end

end