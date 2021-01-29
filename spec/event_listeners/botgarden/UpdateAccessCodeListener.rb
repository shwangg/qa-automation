require_relative '../../../spec_helper'
deploy = Deployment::BOTGARDEN

describe 'BOTGARDEN' do

  include Logging
  include WebDriverManager

  before(:all) do
    @test = TestConfig.new deploy
    @test.set_driver launch_browser

    @admin = @test.get_admin_user
    @current_loc_page = @test.get_page CoreProcedurePage
    @create_new_page = @test.get_page CoreCreateNewPage
    @login_page = @test.get_page CoreLoginPage
    @object_page = @test.get_page CoreObjectPage
    @search_page = @test.get_page CoreSearchPage
    @search_results_page = @test.get_page CoreSearchResultsPage
    @taxon_page = @test.get_page CoreUCBAuthorityPage

    @login_page.load_page
    @login_page.log_in("sehyunhwang@berkeley.edu", "cspacestudents")
    #@admin.username, @admin.password)
  end

  after(:all) { quit_browser @test.driver }

  #Record data to be used in tests
  test_taxon = "Test Taxon "+Time.now.to_i.to_s
  object_1 =  {
    BOTGARDENObjectData::OBJECT_NUM.name => Time.now.to_i * 2,
    BOTGARDENObjectData::TAXON_IDENT_GRP.name => [{BOTGARDENObjectData::TAXON_NAME.name => test_taxon}]
  }
  object_2 = {
    BOTGARDENObjectData::OBJECT_NUM.name => Time.now.to_i * 3,
    BOTGARDENObjectData::TAXON_IDENT_GRP.name => [{BOTGARDENObjectData::TAXON_NAME.name => test_taxon}]
  }
  current_loc_1 = {
    BOTGARDENCurrentLocationData::LOCATION.name => "Asian"
  }
  dead_rec = {
    BOTGARDENCurrentLocationData::ACTION_DATE.name => "12-12-2020",
    BOTGARDENCurrentLocationData::ACTION_CODE.name => "Dead"
  }
  revived_rec = {
    BOTGARDENCurrentLocationData::ACTION_DATE.name => "12-23-2020",
    BOTGARDENCurrentLocationData::ACTION_CODE.name => "Revived",
    BOTGARDENCurrentLocationData::LOCATION.name => "*Asian"
  }
  obj_1_num = {BOTGARDENObjectData::OBJECT_NUM.name => object_1[BOTGARDENObjectData::OBJECT_NUM.name]}
  obj_2_num = {BOTGARDENObjectData::OBJECT_NUM.name => object_2[BOTGARDENObjectData::OBJECT_NUM.name]}
  hash_TODO = {BOTGARDENObjectData::OBJECT_NUM.name => [obj_1_num, obj_2_num]}

  #Variables to be used in tests
  def accession_number; {:xpath => '//header//div//h1//a'} end
  def related_proc_header(accession_num); {:xpath => "//header[contains(., 'Procedures related to #{accession_num}')]"} end
  def row_taxon_name; {:xpath => '//div[@class="cspace-ui-SearchResultTable--common"]//*[@aria-label="row"]//div[@aria-colindex = 3]'} end

  describe 'Test 1 - Create Object, Current Location Records' do
    it "creates new object record and relates current location record" do
      [object_1, object_2].each do |record|
        @search_page.click_create_new_link
        @create_new_page.click_create_new_object
        @object_page.enter_object_number record
        if record == object_1
          @object_page.enter_default_taxonomics record
        else
          @object_page.enter_taxonomics record
        end
        @object_page.save_record

        @object_page.click_current_locations_tab
        @current_loc_page.click_create_new_button
        @current_loc_page.enter_current_loc_data(current_loc_1)
        @current_loc_page.save_record
      end
      @current_loc_page.click_search_link
      @search_page.select_record_type_option("Objects")
      @search_page.enter_object_id_search_data(hash_TODO)
      @search_page.click_search_button

      @search_results_page.wait_for_results
      expect(@search_results_page.elements(@search_results_page.result_rows).length).to eql(2)
      @search_results_page.elements(row_taxon_name).each do |row|
        expect(@search_results_page.element_text(row) == test_taxon)
      end
    end

    it "checks that each object record has a related current location" do
      @search_results_page.click_result(object_1[BOTGARDENObjectData::OBJECT_NUM.name])
      @object_page.expand_sidebar_related_proc
      expect(@object_page.elements(@object_page.related_proc_links).length).to eql(1)
      @object_page.go_back

      @search_results_page.click_result(object_2[BOTGARDENObjectData::OBJECT_NUM.name])
      @object_page.expand_sidebar_related_proc
      expect(@object_page.elements(@object_page.related_proc_links).length).to eql(1)
    end
  end

  describe "Test 3 - Access code updates on Dead" do
    it "checks that Taxon is not Dead and related to records" do
      @object_page.click_sidebar_term(test_taxon)
      expect(@taxon_page.element_value(@taxon_page.access_code_input) == "Dead").to be false
      @taxon_page.expand_sidebar_used_by
      expect(@taxon_page.elements(@taxon_page.used_by_links).length).to eql(2)
    end

    it "Access code updates on Dead when all Procedures Dead" do
      [[object_1[BOTGARDENObjectData::OBJECT_NUM.name], false],
      [object_2[BOTGARDENObjectData::OBJECT_NUM.name], true]].each do |accession_num, bool|
        @taxon_page.click_sidebar_used_by(accession_num)
        @object_page.expand_sidebar_related_proc
        @object_page.click_sidebar_related_proc("Asian")
        @current_loc_page.enter_current_loc_data(dead_rec)
        @current_loc_page.save_record
        @current_loc_page.wait_for_notification("Deleted")
        expect(@current_loc_page.exists? related_proc_header(accession_num)).to be true
        expect(@current_loc_page.elements(@search_results_page.result_rows).length).to eql(0)

        @current_loc_page.click_search_link
        @search_page.select_record_type_option("Taxon names")
        @search_page.enter_display_names([test_taxon])
        @search_page.click_search_button
        @search_results_page.click_result(test_taxon)
        @taxon_page.when_displayed(@taxon_page.access_code_input, Config.short_wait)
        expect(@taxon_page.element_value(@taxon_page.access_code_input) == "dead").to be bool
      end
    end
  end

  describe "Test 5" do
    it "Access code update on Revived" do
      @taxon_page.click_search_link
      @search_page.select_record_type_option("Objects")
      @search_page.enter_object_id_search_data(obj_1_num)
      @search_page.click_search_button
      @search_results_page.click_result(object_1[BOTGARDENObjectData::OBJECT_NUM.name])
      @object_page.click_current_locations_tab
      @current_loc_page.click_create_new_button
      @current_loc_page.enter_current_loc_data(revived_rec)
      @current_loc_page.save_record
      @current_loc_page.click_sidebar_term(test_taxon)
      expect(@taxon_page.element_value(@taxon_page.access_code_input) == "dead").to be false

      @taxon_page.expand_sidebar_used_by
      @taxon_page.click_sidebar_used_by(object_1[BOTGARDENObjectData::OBJECT_NUM.name])
      @object_page.refresh_page
      @object_page.when_displayed(@object_page.dead_flag_input, Config.short_wait)
      sleep Config.click_wait
      expect(@object_page.element_value(@object_page.dead_flag_input) == "no").to be true
    end
  end

end
