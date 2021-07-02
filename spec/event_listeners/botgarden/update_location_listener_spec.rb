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
    [@test_0, @test_5].each do |test|
      @test.set_unique_test_id(test, BOTGARDENObjectData::OBJECT_NUM.name)
    end

    @login_page.load_page
    @login_page.log_in(@admin.username, @admin.password)
  end

  after(:all) { quit_browser @test.driver }

  describe 'Current Location created for a living Accession' do

    it 'create new object record' do
      @search_page.click_create_new_link
      @create_new_page.click_create_new_object
      @object_page.enter_botgarden_object_id_data @test_0
      summary = "#{@test_0[BOTGARDENObjectData::OBJECT_NUM.name]} – #{@test_0[BOTGARDENObjectData::TAXON_IDENT_GRP.name].first[BOTGARDENObjectData::TAXON_NAME.name]}"
      @object_page.click_save_button
      @object_page.wait_for_notification("Saved #{summary}")
      @object_page.close_notifications_bar
      @object_page.verify_values_match(summary, @object_page.element_text(@object_page.page_h1))
      @object_page.expand_sidebar_terms_used
      expect(@object_page.exists? @object_page.terms_used_term_link(@test_0[BOTGARDENObjectData::TAXON_IDENT_GRP.name].first[BOTGARDENObjectData::TAXON_NAME.name])).to be true
    end

    it 'create new location for object record' do
      @object_page.hit_related_tab("Current Locations")
      @object_page.click_create_new_button
      @location_page.enter_botgarden_current_location_data @test_1
      summary = "#{@test_1[BOTGARDENCurrentLocationData::GARDEN_LOCATION.name]} – #{@test_1[BOTGARDENCurrentLocationData::ACTION_DATE.name]}"
      @location_page.click_save_button
      @location_page.wait_for_notification("Saved #{summary}")
      @location_page.close_notifications_bar
      @location_page.verify_values_match(summary, @location_page.element_text(@location_page.related_record_h1))
      @location_page.expand_sidebar_related_proc
      expect(@location_page.exists? @location_page.related_proc_link(@test_1[BOTGARDENCurrentLocationData::GARDEN_LOCATION.name])).to be true
      expect(@search_results_page.row_exists?(@test_1[BOTGARDENCurrentLocationData::GARDEN_LOCATION.name])).to be true
    end
  end

  describe 'Current Location record modified for a living Accession' do
    it 'changes location for object record' do
      @location_page.enter_botgarden_current_location_data @test_2
      summary = "#{@test_2[BOTGARDENCurrentLocationData::GARDEN_LOCATION.name]} – #{@test_1[BOTGARDENCurrentLocationData::ACTION_DATE.name]}"
      @location_page.click_save_button
      @location_page.wait_for_notification("Saved #{summary}")
      @location_page.close_notifications_bar
      @location_page.verify_values_match(summary, @location_page.element_text(@location_page.related_record_h1))
      expect(@location_page.exists? @location_page.related_proc_link(@test_2[BOTGARDENCurrentLocationData::GARDEN_LOCATION.name])).to be true
      expect(@search_results_page.row_exists?(@test_2[BOTGARDENCurrentLocationData::GARDEN_LOCATION.name])).to be true
    end

    it 'adds a note for garden location' do
      @location_page.enter_botgarden_current_location_data @test_3
      summary = "#{@test_2[BOTGARDENCurrentLocationData::GARDEN_LOCATION.name]} – #{@test_1[BOTGARDENCurrentLocationData::ACTION_DATE.name]}"
      @location_page.click_save_button
      @location_page.wait_for_notification("Saved #{summary}")
      @location_page.close_notifications_bar
      @location_page.verify_values_match(summary, @location_page.element_text(@location_page.related_record_h1))
      expect(@location_page.exists? @location_page.related_proc_link(@test_2[BOTGARDENCurrentLocationData::GARDEN_LOCATION.name])).to be true
      expect(@search_results_page.row_exists?(@test_2[BOTGARDENCurrentLocationData::GARDEN_LOCATION.name])).to be true
    end

    it 'record remains the same if saved without any new changes' do
      summary = "#{@test_2[BOTGARDENCurrentLocationData::GARDEN_LOCATION.name]} – #{@test_1[BOTGARDENCurrentLocationData::ACTION_DATE.name]}"
      @location_page.click_save_button
      @location_page.wait_for_notification("Saved #{summary}")
      @location_page.close_notifications_bar
      @location_page.verify_values_match(summary, @location_page.element_text(@location_page.related_record_h1))
      expect(@location_page.exists? @location_page.related_proc_link(@test_2[BOTGARDENCurrentLocationData::GARDEN_LOCATION.name])).to be true
      expect(@search_results_page.row_exists?(@test_2[BOTGARDENCurrentLocationData::GARDEN_LOCATION.name])).to be true
    end
  end

  describe 'Current Location record “deaded”' do
    it 'changes the action code to Dead' do
      @location_page.enter_botgarden_current_location_data @test_4
      summary = "#{@test_2[BOTGARDENCurrentLocationData::GARDEN_LOCATION.name]} – #{@test_1[BOTGARDENCurrentLocationData::ACTION_DATE.name]}"
      @location_page.click_save_button
      @location_page.wait_for_notification("Saved #{summary}")
      @location_page.wait_for_notification("Deleted #{@test_1[BOTGARDENCurrentLocationData::ACTION_DATE.name]}")
      @location_page.close_notifications_bar
      @location_page.close_notifications_bar
      expect(@location_page.exists? @location_page.related_proc_link(@test_2[BOTGARDENCurrentLocationData::GARDEN_LOCATION.name])).to be false
      expect(@search_results_page.row_exists?(@test_2[BOTGARDENCurrentLocationData::GARDEN_LOCATION.name])).to be false
    end
  end

  describe 'Special case: Current Location created for a dead Accession' do
    it 'create a new Object Record' do
      @object_page.click_create_new_link
      @create_new_page.click_create_new_object
      @object_page.enter_botgarden_object_id_data @test_5
      summary = "#{@test_5[BOTGARDENObjectData::OBJECT_NUM.name]} – #{@test_5[BOTGARDENObjectData::TAXON_IDENT_GRP.name].first[BOTGARDENObjectData::TAXON_NAME.name]}"
      @object_page.click_save_button
      @object_page.wait_for_notification("Saved #{summary}")
      @object_page.close_notifications_bar
      @object_page.verify_values_match(summary, @object_page.element_text(@object_page.page_h1))
      @object_page.expand_sidebar_terms_used
      expect(@object_page.exists? @object_page.terms_used_term_link(@test_5[BOTGARDENObjectData::TAXON_IDENT_GRP.name].first[BOTGARDENObjectData::TAXON_NAME.name])).to be true
    end

    it 'create new dead location for object record' do
      @object_page.hit_related_tab("Current Locations")
      @object_page.click_create_new_button
      @location_page.enter_botgarden_current_location_data @test_6
      summary = "#{@test_6[BOTGARDENCurrentLocationData::GARDEN_LOCATION.name]} – #{@test_6[BOTGARDENCurrentLocationData::ACTION_DATE.name]}"
      @location_page.click_save_button
      @location_page.wait_for_notification("Saved #{summary}")
      @location_page.wait_for_notification("Deleted #{@test_6[BOTGARDENCurrentLocationData::ACTION_DATE.name]}")
      @location_page.close_notifications_bar
      @location_page.close_notifications_bar
      @location_page.expand_sidebar_related_proc
      expect(@location_page.exists? @location_page.related_proc_link(@test_6[BOTGARDENCurrentLocationData::GARDEN_LOCATION.name])).to be false
      expect(@location_page.elements(@search_results_page.result_rows)).to be_empty
    end
  end

  describe 'Alert notification for broken relationship on delete of ‘deaded’ plant' do
    it 'create a new current locations relation' do
      @object_page.click_create_new_button
      @location_page.click_save_button
    end
    it 'when clicking the Unrelate button' do
      @location_page.click_relation_editor_unrelate_button
      @location_page.verify_values_match("Unrelate Current Location", @location_page.element_text(@location_page.dialog_header))
      @location_page.when_exists(@location_page.confirm_unrelate_msg_span, Config.short_wait)
      @location_page.click_relation_editor_cancel_button
    end
    it 'when clicking the Delete button' do
      @location_page.click_delete_button
      @location_page.when_exists(@location_page.confirm_delete_msg_span, Config.short_wait)
      @location_page.cancel_deletion
    end
    it 'when setting the Action code field to ‘Dead’' do
      @location_page.close_notifications_bar
      @location_page.enter_botgarden_current_location_data @test_4
      @location_page.click_save_button
      @location_page.when_exists(@location_page.confirm_delete_msg_span, Config.short_wait)
    end
  end
end
