require_relative '../../../spec_helper'

describe 'BOTGARDEN' do

  include Logging
  include WebDriverManager

  before(:all) do
    @test = TestConfig.new Deployment::BOTGARDEN
    @test.set_driver launch_browser

    @admin = @test.get_admin_user
    @create_new_page = CreateNewPage.new @test
    @login_page = LoginPage.new @test
    @object_page = ObjectPage.new @test
    @location_page = InventoryMovementPage.new @test

    @search_page = SearchPage.new @test
    @search_results_page = SearchResultsPage.new @test

    @test_0 = {
      BOTGARDENObjectData::TAXON_IDENT_GRP.name => [{BOTGARDENObjectData::TAXON_NAME.name => "Ast"}]
    }
    @test_1 = {
      BOTGARDENCurrentLocationData::ACTION_DATE.name => (Date.today - 1).to_s,
      BOTGARDENCurrentLocationData::GARDEN_LOCATION.name => "*Asian"
    }
    @test_2 = {
      BOTGARDENCurrentLocationData::ACTION_DATE.name => (Date.today - 2).to_s,
      BOTGARDENCurrentLocationData::GARDEN_LOCATION.name => "*South America"
    }
    @test_3 = {
      BOTGARDENCurrentLocationData::MOVEMENT_NOTE.name => "this is a note"
    }

    @login_page.load_page
    @login_page.log_in(@admin.username, @admin.password)
  end

  after(:all) { quit_browser @test.driver }

  it 'Create new Object record' do
    @test.set_unique_test_id(@test_0, BOTGARDENObjectData::OBJECT_NUM.name)
    @search_page.click_create_new_link
    @create_new_page.click_create_new_object
    @object_page.enter_botgarden_object_id_data @test_0
    summary = "#{@test_0[BOTGARDENObjectData::OBJECT_NUM.name]} – #{@test_0[BOTGARDENObjectData::TAXON_IDENT_GRP.name].first[BOTGARDENObjectData::TAXON_NAME.name]}"
    @object_page.click_save_button
    @object_page.wait_for_notification("Saved #{summary}")
    @location_page.close_notifications_bar
    @object_page.verify_values_match(summary, @object_page.element_text(@object_page.page_h1))
  end

  it 'Add a related Current Location' do
    @object_page.hit_related_tab("Current Locations")
    @object_page.click_create_new_button
    @location_page.enter_botgarden_current_location_data @test_1
    summary = "#{@test_1[BOTGARDENCurrentLocationData::GARDEN_LOCATION.name]} – #{@test_1[BOTGARDENCurrentLocationData::ACTION_DATE.name]}"
    @location_page.click_save_button
    @location_page.wait_for_notification("Saved #{summary}")
    @location_page.close_notifications_bar
    @location_page.verify_values_match(summary, @location_page.element_text(@location_page.related_record_h1))
    @location_page.expand_sidebar_related_proc
    @location_page.expand_sidebar_terms_used
    expect(@search_results_page.row_exists?(@test_1[BOTGARDENCurrentLocationData::GARDEN_LOCATION.name])).to be true
    expect(@location_page.exists? @location_page.related_proc_link(@test_1[BOTGARDENCurrentLocationData::GARDEN_LOCATION.name])).to be true
    expect(@location_page.exists? @location_page.terms_used_term_link(@test_0[BOTGARDENObjectData::TAXON_IDENT_GRP.name].first[BOTGARDENObjectData::TAXON_NAME.name])).to be true
  end


  it 'Move Accession to a new Current Location' do
    @location_page.click_create_new_button
    @location_page.enter_botgarden_current_location_data @test_2
    summary = "#{@test_2[BOTGARDENCurrentLocationData::GARDEN_LOCATION.name]} – #{@test_2[BOTGARDENCurrentLocationData::ACTION_DATE.name]}"
    @location_page.click_save_button
    @location_page.wait_for_notification("Saved #{summary}")
    @location_page.close_notifications_bar
    @location_page.verify_values_match(summary, @location_page.element_text(@location_page.related_record_h1))
    expect(@search_results_page.botgarden_name_of_nth_row(1)).to eql(@test_2[BOTGARDENCurrentLocationData::GARDEN_LOCATION.name])
    expect(@location_page.element_text(@location_page.related_proc_nth_link(1))).to eql(@test_2[BOTGARDENCurrentLocationData::GARDEN_LOCATION.name])
    expect(@location_page.exists? @location_page.terms_used_term_link(@test_0[BOTGARDENObjectData::TAXON_IDENT_GRP.name].first[BOTGARDENObjectData::TAXON_NAME.name])).to be true
  end

  it 'Modify Current Locations record without changing the Garden location' do
    @location_page.enter_botgarden_current_location_data @test_3
    summary = "#{@test_2[BOTGARDENCurrentLocationData::GARDEN_LOCATION.name]} – #{@test_2[BOTGARDENCurrentLocationData::ACTION_DATE.name]}"
    @location_page.click_save_button
    @location_page.click_save_button
    @location_page.wait_for_notification("Saved #{summary}")
    @location_page.close_notifications_bar
    @location_page.verify_values_match(summary, @location_page.element_text(@location_page.related_record_h1))
    expect(@search_results_page.botgarden_name_of_nth_row(1)).to eql(@test_2[BOTGARDENCurrentLocationData::GARDEN_LOCATION.name])
    expect(@location_page.elements(@location_page.related_proc_links).length).to eql(2)
  end
end
