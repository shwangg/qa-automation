require_relative '../../../spec_helper'
test_run = TestConfig.new Deployment::BOTGARDEN

describe 'BOTGARDEN' do

  include Logging
  include WebDriverManager

  before(:all) do

    test_run.set_driver launch_browser
    @admin = test_run.get_admin_user
    @login_page = test_run.get_page BOTGARDENLoginPage
  #  @search_page = test_run.get_page CoreSearchPage
  #  @search_results_page = test_run.get_page CoreSearchResultsPage
    @login_page.load_page
  #  @concept_page = test_run.get_page CoreConceptPage
  #  @create_new_page = test_run.get_page CoreCreateNewPage
    @login_page.log_in("sehyunhwang@berkeley.edu", "cspacestudents")
    #@admin.username, @admin.password)
  end

  after(:all) { quit_browser test_run.driver }
=begin
  search_result = "N/A"

  it "find conservation category value with set qualifier field" do
    @search_page.quick_search("Concepts", "Conservation Category", "red dot on label")
    search_result = @search_result.name_of_nth_row(1)
    @search_result.select_result_nth_row(1)

    qualifier_text = @concept_page.element_value(@concept_page.input_locator([], "termQualifier"))
    @concept_page.verify_values_match("red dot on label", qualifier_text)
  end

  it "create a new object record" do
    @concept_page.click_create_new_link
    @create_new_page.click_create_new_object
  end
=end
end
