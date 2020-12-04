require_relative '../../../spec_helper'
deploy = Deployment::BOTGARDEN

describe 'BOTGARDEN' do

  include Logging
  include WebDriverManager

  before(:all) do
    @test = TestConfig.new deploy
    @test.set_driver launch_browser
  #  @admin = @test.get_admin_user
    @login_page = @test.get_page CoreLoginPage
    @search_page = @test.get_page CoreSearchPage
    @search_results_page = @test.get_page CoreSearchResultsPage
    @login_page.load_page
    @concept_page = @test.get_page CoreConceptPage
    @create_new_page = @test.get_page CoreCreateNewPage
    @object_page = @test.get_page CoreObjectPage
    @login_page.log_in("sehyunhwang@berkeley.edu", "cspacestudents")
    #@admin.username, @admin.password)
  end

  after(:all) { quit_browser @test.driver }

  search_result = "N/A"

  it "find conservation category value with set qualifier field" do
    @search_page.quick_search("Concepts", "Conservation Category", "red dot on label")
    search_result = @search_results_page.name_of_nth_row(1)
    @search_results_page.select_result_nth_row(1)
  #  @concept_page.refresh_page
    @concept_page.verify_qualifier_name("red dot on label", 0)
  end

  it "create a new object record" do
    @concept_page.click_create_new_link
    @create_new_page.click_create_new_object
    obj_rec = {
      BOTGARDENObjectData::OBJECT_NUM.name => "1345433",
      BOTGARDENObjectData::TAXON_IDENT_GRP.name => [{BOTGARDENObjectData::TAXON_NAME.name => "Astelia"}]
    }
    @object_page.enter_object_number obj_rec
    @object_page.enter_taxonomics obj_rec

    @object_page.save_record
    ##EXPECTED
    #record should save
    #

  end

end
