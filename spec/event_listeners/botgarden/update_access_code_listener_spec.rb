require_relative '../../../spec_helper'

describe 'BOTGARDEN' do

  include Logging
  include WebDriverManager

  before(:all) do
    @test = TestConfig.new Deployment::BOTGARDEN
    @test.set_driver launch_browser

    @admin = @test.get_admin_user
    @current_loc_page = InventoryMovementPage.new @test
    @create_new_page = CreateNewPage.new @test
    @login_page = LoginPage.new @test
    @object_page = ObjectPage.new @test
    @search_page = SearchPage.new @test
    @search_results_page = SearchResultsPage.new @test
    @taxon_page = TaxonPage.new @test

    @login_page.load_page
    @login_page.log_in(@admin.username, @admin.password)
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
    BOTGARDENCurrentLocationData::GARDEN_LOCATION.name => "Asian"
  }
  dead_rec = {
    BOTGARDENCurrentLocationData::ACTION_DATE.name => "12-12-2020",
    BOTGARDENCurrentLocationData::ACTION_CODE.name => "Dead"
  }
  revived_rec = {
    BOTGARDENCurrentLocationData::ACTION_DATE.name => "12-23-2020",
    BOTGARDENCurrentLocationData::ACTION_CODE.name => "Revived",
    BOTGARDENCurrentLocationData::GARDEN_LOCATION.name => "*Asian"
  }
  obj_1_num = {BOTGARDENObjectData::OBJECT_NUM.name => object_1[BOTGARDENObjectData::OBJECT_NUM.name]}
  obj_2_num = {BOTGARDENObjectData::OBJECT_NUM.name => object_2[BOTGARDENObjectData::OBJECT_NUM.name]}
  search_data = {BOTGARDENObjectData::OBJECT_NUM.name => [obj_1_num, obj_2_num]}

  describe 'Test 1 - Create Object, Current Location Records' do
    it "creates new object record and relates current location record" do
      [[object_1, "Default"],[object_2, nil]].each do |record, default_name|
        @search_page.click_create_new_link
        @create_new_page.click_create_new_object
        @object_page.enter_botgarden_accession_num record
        @object_page.enter_taxonomics(record, default_name)
        @object_page.save_record

        @object_page.click_current_locations_tab
        @current_loc_page.click_create_new_button
        @current_loc_page.enter_botgarden_current_location_data(current_loc_1)
        @current_loc_page.save_record
      end
      @current_loc_page.click_search_link
      @search_page.select_record_type_option("Objects")
      @search_page.enter_object_id_search_data(search_data)
      @search_page.click_search_button

      @search_results_page.wait_for_results
      expect(@search_results_page.elements(@search_results_page.result_rows).length).to eql(2)
      @search_results_page.elements(@search_results_page.botgarden_taxonomic_name_column).each do |row|
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
      expect(@taxon_page.element_value(@taxon_page.botgarden_access_code_input) == "Dead").to be false
      @taxon_page.expand_sidebar_used_by
      expect(@taxon_page.elements(@taxon_page.used_by_links).length).to eql(2)
    end

    it "Access code updates on Dead when all Procedures Dead" do
      [[object_1[BOTGARDENObjectData::OBJECT_NUM.name], false],
      [object_2[BOTGARDENObjectData::OBJECT_NUM.name], true]].each do |accession_num, bool|
        @taxon_page.click_sidebar_used_by(accession_num)
        @object_page.expand_sidebar_related_proc
        @object_page.click_sidebar_related_proc("Asian")
        @current_loc_page.enter_botgarden_current_location_data(dead_rec)
        @current_loc_page.save_record
        @current_loc_page.wait_for_notification("Deleted")
        expect(@current_loc_page.element_text(@search_results_page.title_bar_header_text)).to eql("Procedures related to #{accession_num}")
        expect(@current_loc_page.elements(@search_results_page.result_rows).length).to eql(0)

        @current_loc_page.click_search_link
        @search_page.select_record_type_option("Taxon names")
        @search_page.enter_display_names([test_taxon])
        @search_page.click_search_button
        @search_results_page.click_result(test_taxon)
        @taxon_page.when_displayed(@taxon_page.botgarden_access_code_input, Config.short_wait)
        expect(@taxon_page.element_value(@taxon_page.botgarden_access_code_input) == "dead").to be bool
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
      @current_loc_page.enter_botgarden_current_location_data(revived_rec)
      @current_loc_page.save_record
      @current_loc_page.click_sidebar_term(test_taxon)
      expect(@taxon_page.element_value(@taxon_page.botgarden_access_code_input) == "dead").to be false

      #@taxon_page.expand_sidebar_used_by
      @taxon_page.click_sidebar_used_by(object_1[BOTGARDENObjectData::OBJECT_NUM.name])
      @object_page.refresh_page
      @object_page.when_displayed(@object_page.botgarden_dead_flag_input, Config.short_wait)
      sleep Config.click_wait
      expect(@object_page.element_value(@object_page.botgarden_dead_flag_input) == "no").to be true
    end
  end

end
