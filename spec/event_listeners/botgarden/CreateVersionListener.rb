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

    @login_page.load_page
    @login_page.log_in(@admin.username, @admin.password)
  end

  after(:all) { quit_browser @test.driver }

  title_bar = {:xpath => '//header[contains(@class,"TitleBar")]//h1'}
  relations_bar = {:xpath => '//div[contains(@class,"RelationEditor")]//header//h1'}


  it 'Create new Object record' do
    @test.set_unique_test_id(@test_0, BOTGARDENObjectData::OBJECT_NUM.name)
    @search_page.click_create_new_link
    @create_new_page.click_create_new_object
    @object_page.enter_botgarden_accession_num @test_0
    @object_page.enter_botgarden_taxonomics @test_0
    summary = "#{@test_0[BOTGARDENObjectData::OBJECT_NUM.name]} – #{@test_0[BOTGARDENObjectData::TAXON_IDENT_GRP.name].first[BOTGARDENObjectData::TAXON_NAME.name]}"
    @object_page.click_save_button
    @object_page.wait_for_notification("Saved #{summary}")
    @location_page.close_notifications_bar
    @object_page.verify_values_match(summary, @object_page.element_text(title_bar))
  end

  it 'Add a related Current Location' do
    @object_page.hit_related_tab("Current Locations")
    @object_page.click_create_new_button
    @location_page.enter_botgarden_current_location_data @test_1
    summary = "#{@test_1[BOTGARDENCurrentLocationData::GARDEN_LOCATION.name]} – #{@test_1[BOTGARDENCurrentLocationData::ACTION_DATE.name]}"
    @location_page.click_save_button
    @location_page.wait_for_notification("Saved #{summary}")
    @location_page.close_notifications_bar
    @location_page.verify_values_match(summary, @location_page.element_text(relations_bar))
  end


  it 'Move Accession to a new Current Location' do
    @location_page.enter_botgarden_current_location_data @test_2
    summary = "#{@test_2[BOTGARDENCurrentLocationData::GARDEN_LOCATION.name]} – #{@test_1[BOTGARDENCurrentLocationData::ACTION_DATE.name]}"
    @location_page.click_save_button
    @location_page.wait_for_notification("Saved #{summary}")
    @location_page.close_notifications_bar
    @location_page.verify_values_match(summary, @location_page.element_text(relations_bar))
  end

  it 'Modify Current Locations record without changing the Garden location' do
    @location_page.enter_botgarden_current_location_data @test_3
    summary = "#{@test_2[BOTGARDENCurrentLocationData::GARDEN_LOCATION.name]} – #{@test_1[BOTGARDENCurrentLocationData::ACTION_DATE.name]}"
    @location_page.click_save_button
    @location_page.wait_for_notification("Saved #{summary}")
    @location_page.close_notifications_bar
    @location_page.verify_values_match(summary, @location_page.element_text(relations_bar))
  end
end
