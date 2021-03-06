require_relative '../../../spec_helper'

describe 'BOTGARDEN' do

  include Logging
  include WebDriverManager
  
  before(:all) do
    @test = TestConfig.new Deployment::BOTGARDEN
    @test.set_driver launch_browser

    @admin = @test.get_admin_user
    @concept_page = ConceptPage.new @test
    @create_new_page = CreateNewPage.new @test
    @login_page = LoginPage.new @test
    @object_page = ObjectPage.new @test
    @location_page = InventoryMovementPage.new @test

    @search_page = SearchPage.new @test
    @search_results_page = SearchResultsPage.new @test
    @taxon_page = TaxonPage.new @test

    @test_0 = {
      BOTGARDENObjectData::TAXON_IDENT_GRP.name => [{BOTGARDENObjectData::TAXON_NAME.name => "Ast"}]
    }
    @test_1 = {
      BOTGARDENCurrentLocationData::ACTION_DATE.name => (Date.today - 1).to_s,
      BOTGARDENCurrentLocationData::GARDEN_LOCATION.name => "*Asian"
    }
    @test_2 = {
      BOTGARDENCurrentLocationData::GARDEN_LOCATION.name => "*South America"
    }
    @test_3 = {
      BOTGARDENCurrentLocationData::MOVEMENT_NOTE.name => "this is a note"
    }
    @test_4 = {
      BOTGARDENCurrentLocationData::ACTION_CODE.name => "Dead"
    }
    @test_5 = {
      BOTGARDENObjectData::TAXON_IDENT_GRP.name => [{BOTGARDENObjectData::TAXON_NAME.name => "Ast"}]
    }
    @test_6 = {
      BOTGARDENCurrentLocationData::ACTION_DATE.name => (Date.today - 1).to_s,
      BOTGARDENCurrentLocationData::GARDEN_LOCATION.name => "*Asian",
      BOTGARDENCurrentLocationData::ACTION_CODE.name => "Dead"
    }

    @login_page.load_page
    @login_page.log_in(@admin.username, @admin.password)
  end

  after(:all) { quit_browser @test.driver }

  title_bar = {:xpath => '//header[contains(@class,"TitleBar")]//h1'}
  relations_bar = {:xpath => '//div[contains(@class,"RelationEditor")]//header//h1'}
  unrelate_modal = {:xpath => '//div[contains(@class,"ConfirmRecordUnrelateModal")]//span[contains(.,"Unrelate Current Location")]'}


  describe 'Current Location created for a living Accession' do

    it 'create new object record' do
      @test.set_unique_test_id(@test_0, BOTGARDENObjectData::OBJECT_NUM.name)
      @search_page.click_create_new_link
      @create_new_page.click_create_new_object
      @object_page.enter_object_number @test_0
      @object_page.enter_botgarden_taxonomics @test_0
      summary = "#{@test_0[BOTGARDENObjectData::OBJECT_NUM.name]} – #{@test_0[BOTGARDENObjectData::TAXON_IDENT_GRP.name].first[BOTGARDENObjectData::TAXON_NAME.name]}"
      @object_page.click_save_button
      @object_page.wait_for_notification("Saved #{summary}")
      @location_page.close_notifications_bar
      @object_page.verify_values_match(summary, @object_page.element_text(title_bar))
    end

    it 'create new location for object record' do
      @object_page.hit_related_tab("Current Locations")
      @object_page.click_create_new_button
      @location_page.enter_botgarden_current_location_data @test_1
      summary = "#{@test_1[BOTGARDENCurrentLocationData::GARDEN_LOCATION.name]} – #{@test_1[BOTGARDENCurrentLocationData::ACTION_DATE.name]}"
      @location_page.click_save_button
      @location_page.wait_for_notification("Saved #{summary}")
      @location_page.close_notifications_bar
      @location_page.verify_values_match(summary, @location_page.element_text(relations_bar))
    end
  end

  describe 'Current Location record modified for a living Accession' do
    it 'changes location for object record' do
      @location_page.enter_botgarden_current_location_data @test_2
      summary = "#{@test_2[BOTGARDENCurrentLocationData::GARDEN_LOCATION.name]} – #{@test_1[BOTGARDENCurrentLocationData::ACTION_DATE.name]}"
      @location_page.click_save_button
      @location_page.wait_for_notification("Saved #{summary}")
      @location_page.close_notifications_bar
      @location_page.verify_values_match(summary, @location_page.element_text(relations_bar))
    end

    it 'adds a note for garden location' do
      @location_page.enter_botgarden_current_location_data @test_3
      summary = "#{@test_2[BOTGARDENCurrentLocationData::GARDEN_LOCATION.name]} – #{@test_1[BOTGARDENCurrentLocationData::ACTION_DATE.name]}"
      @location_page.click_save_button
      @location_page.wait_for_notification("Saved #{summary}")
      @location_page.close_notifications_bar
      @location_page.verify_values_match(summary, @location_page.element_text(relations_bar))
    end
  end

  describe 'Current Location record “deaded”' do
    it 'changes the action code to Dead' do
      @location_page.enter_botgarden_current_location_data @test_4
      summary = "#{@test_2[BOTGARDENCurrentLocationData::GARDEN_LOCATION.name]} – #{@test_1[BOTGARDENCurrentLocationData::ACTION_DATE.name]}"
      @location_page.click_save_button
      @location_page.wait_for_notification("Saved #{summary}")
      @location_page.wait_for_notification("Deleted #{@test_2[BOTGARDENCurrentLocationData::ACTION_DATE.name]}")
      @location_page.close_notifications_bar
      @location_page.close_notifications_bar

    end
  end

  describe 'Special case: Current Location created for a dead Accession' do
    it 'create a new Object Record' do
      @test.set_unique_test_id(@test_5, BOTGARDENObjectData::OBJECT_NUM.name)
      @object_page.click_create_new_link
      @create_new_page.click_create_new_object
      @object_page.enter_object_number @test_5
      @object_page.enter_botgarden_taxonomics @test_5
      summary = "#{@test_5[BOTGARDENObjectData::OBJECT_NUM.name]} – #{@test_5[BOTGARDENObjectData::TAXON_IDENT_GRP.name].first[BOTGARDENObjectData::TAXON_NAME.name]}"
      @object_page.click_save_button
      @object_page.wait_for_notification("Saved #{summary}")
      @location_page.close_notifications_bar
      @object_page.verify_values_match(summary, @object_page.element_text(title_bar))
    end

    it 'create new dead location for object record' do
      @object_page.hit_related_tab("Current Locations")
      @object_page.click_create_new_button
      @location_page.enter_botgarden_current_location_data @test_6
      summary = "#{@test_6[BOTGARDENCurrentLocationData::GARDEN_LOCATION.name]} – #{@test_6[BOTGARDENCurrentLocationData::ACTION_DATE.name]}"
      @location_page.click_save_button
      @location_page.wait_for_notification("Saved #{summary}")
      @location_page.wait_for_notification("Deleted #{@test_2[BOTGARDENCurrentLocationData::ACTION_DATE.name]}")
      @location_page.close_notifications_bar
      @location_page.close_notifications_bar
    end
  end

  describe 'Alert notification for broken relationship on delete of ‘deaded’ plant' do
    it 'create a new current locations relation' do
      @object_page.click_create_new_button
      @location_page.click_save_button
      @location_page.click_relation_editor_unrelate_button
      @location_page.when_exists(unrelate_modal, Config.short_wait)
      @location_page.click_relation_editor_cancel_button
      @location_page.click_delete_button
      @location_page.cancel_deletion
      @location_page.enter_botgarden_current_location_data @test_4
      @location_page.click_save_button
    end
  end
end
