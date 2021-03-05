require_relative '../../../spec_helper'

describe 'CollectionSpace', order: :defined do

  include Logging
  include WebDriverManager

  test_run = TestConfig.new Deployment::CORE_UCB
  test_data = test_run.special_characters_test_data
  test_data["objects"].each { |test| test_run.set_unique_test_id(test, CoreObjectData::OBJECT_NUM.name); sleep(1) }

  test_data["Autocomplete Test"][CoreObjectData::CONTENT_PERSONS.name].each do |t|
    test_run.set_unique_test_id(t, CoreObjectData::CONTENT_PERSON.name)
  end

  before(:all) do
    test_run.set_driver launch_browser
    @admin = test_run.get_admin_user
    @object_page = ObjectPage.new test_run
    @create_new_page = CreateNewPage.new test_run
    @search_results_page = SearchResultsPage.new test_run
    @login_page = LoginPage.new test_run

    @login_page.load_page
    @login_page.log_in(@admin.username, @admin.password)

    @char_object = {
      CoreObjectData::OBJECT_NUM.name => Time.now.to_i,
    }
  end

  after(:all) { quit_browser test_run.driver }

  test_data["objects"].each do |test|
    it("allows ASCII Special Characters in data input '#{test}'") do
      @object_page.hide_notifications_bar
      @object_page.click_create_new_link
      @create_new_page.click_create_new_object
      @object_page.enter_object_number test
      @object_page.enter_comments test
      @object_page.enter_titles test
      @object_page.save_record

      @object_page.verify_object_num test
      @object_page.verify_comments test
      @object_page.verify_titles test
    end
  end

  it "allows strings of over 500 characters in data input " do
    @object_page.enter_dist_features(str = 'Lots of characters in this string. ' * 15)
    @object_page.save_record
    @object_page.verify_distinguishing_features str
  end

  test_data["Non-ASCII char"].each do |test|
    it "allows Non-ASCII Characters in data input '#{test}'" do
      @object_page.hide_notifications_bar
      @object_page.enter_comments test
      @object_page.enter_dist_features test
      @object_page.enter_titles test
      @object_page.save_record

      @object_page.verify_comments test
      @object_page.verify_distinguishing_features test
      @object_page.verify_titles test
    end
  end

  it "allows ASCII Special Characters & Non-ASCII Characters in autocomplete fields #{test_data["Autocomplete Test"]}" do
    test = test_data["Autocomplete Test"]
    @object_page.hide_notifications_bar
    @object_page.uncollapse_panel_if_collapsed("Object Description Information")
    @object_page.uncollapse_subpanel_if_collapsed("Content")
    @object_page.enter_content_person test
    @object_page.save_record
    @object_page.verify_content_person test
  end

  test_data["Autocomplete Test"][CoreObjectData::CONTENT_PERSONS.name].each do |test|
    it "allows Special Characters in Search #{test}" do
      @object_page.quick_search("Persons", "All", test[CoreObjectData::CONTENT_PERSON.name])
      expect(@search_results_page.row_exists?(test[CoreObjectData::CONTENT_PERSON.name])).to be true
    end
  end
end
