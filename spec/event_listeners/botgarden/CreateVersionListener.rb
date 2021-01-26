require_relative '../../../spec_helper'
deploy = Deployment::BOTGARDEN

describe 'BOTGARDEN' do

  include Logging
  include WebDriverManager

  test_run = TestConfig.new deploy
  test_id = Time.now.to_i

  before(:all) do
    test_run.set_driver launch_browser

    @admin = test_run.get_admin_user
    @concept_page = test_run.get_page CoreConceptPage
    @create_new_page = test_run.get_page CoreCreateNewPage
    @login_page = test_run.get_page CoreLoginPage
    @object_page = test_run.get_page CoreObjectPage
    @location_page = test_run.get_page CoreCurrentLocationPage

    @search_page = test_run.get_page CoreSearchPage
    @search_results_page = test_run.get_page CoreSearchResultsPage
    @taxon_page = test_run.get_page CoreUCBAuthorityPage

    @test_0 = {
      # BOTGARDENObjectData::OBJECT_NUM.name => Time.now.to_i,
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

  after(:all) { quit_browser test_run.driver }

  title_bar = {:xpath => '//header[contains(@class,"TitleBar")]//h1'}
  relations_bar = {:xpath => '//div[contains(@class,"RelationEditor")]//header//h1'}


  it 'Create new Object record' do
    test_run.set_unique_test_id(@test_0, BOTGARDENObjectData::OBJECT_NUM.name)
    @search_page.click_create_new_link
    @create_new_page.click_create_new_object
    @object_page.enter_object_number @test_0
    @object_page.enter_default_taxonomics @test_0
    summary = "#{@test_0[BOTGARDENObjectData::OBJECT_NUM.name]} – #{@test_0[BOTGARDENObjectData::TAXON_IDENT_GRP.name].first[BOTGARDENObjectData::TAXON_NAME.name]}"
    @object_page.click_save_button
    # @object_page.wait_for_notification("Saving #{summary}")
    @object_page.wait_for_notification("Saved #{summary}")
    @location_page.close_notifications_bar
    @object_page.verify_values_match(summary, @object_page.element_text(title_bar))
  end

  it 'Add a related Current Location' do
    @object_page.hit_related_tab("Current Locations")
    @object_page.click_create_new_button
    @location_page.enter_current_location_data @test_1
    summary = "#{@test_1[BOTGARDENCurrentLocationData::GARDEN_LOCATION.name]} – #{@test_1[BOTGARDENCurrentLocationData::ACTION_DATE.name]}"
    @location_page.click_save_button
    # @location_page.wait_for_notification("Saving #{summary}")
    @location_page.wait_for_notification("Saved #{summary}")
    @location_page.close_notifications_bar
    @location_page.verify_values_match(summary, @location_page.element_text(relations_bar))
  end

  
  it 'Move Accession to a new Current Location' do
    @location_page.enter_current_location_data @test_2
    summary = "#{@test_2[BOTGARDENCurrentLocationData::GARDEN_LOCATION.name]} – #{@test_1[BOTGARDENCurrentLocationData::ACTION_DATE.name]}"
    @location_page.click_save_button
    # @location_page.wait_for_notification("Saving #{summary}")
    @location_page.wait_for_notification("Saved #{summary}")
    @location_page.close_notifications_bar
    @location_page.verify_values_match(summary, @location_page.element_text(relations_bar))
  end

  it 'Modify Current Locations record without changing the Garden location' do
    @location_page.enter_current_location_data @test_3
    summary = "#{@test_2[BOTGARDENCurrentLocationData::GARDEN_LOCATION.name]} – #{@test_1[BOTGARDENCurrentLocationData::ACTION_DATE.name]}"
    @location_page.click_save_button
    # @location_page.wait_for_notification("Saving #{summary}")
    @location_page.wait_for_notification("Saved #{summary}")
    @location_page.close_notifications_bar
    @location_page.verify_values_match(summary, @location_page.element_text(relations_bar))
  end

  # it 'Confirm via API (or database) query that versions exist' do
  # end

  # it 'Review the Accession History report for the Accession' do
  #   @object_page.expand_sidebar_reports
  #   @object_page.scroll_to_bottom
  #   @object_page.click_sidebar_report("Accession History")

  #   @object_page.click_invoke_button
  # end

end