require_relative '../../../spec_helper'

describe 'CollectionSpace' do

  include Logging
  include WebDriverManager

  before(:all) do
    @test = TestConfig.new Deployment::CORE
    @test.set_driver launch_browser
    @admin = @test.get_admin_user
    @login_page = LoginPage.new @test
    @create_new_page = CreateNewPage.new @test
    @search_page = SearchPage.new @test
    @search_results_page = SearchResultsPage.new @test
    @object_page = ObjectPage.new @test
    @movement_page = InventoryMovementPage.new @test

    @object_1 = {
      CoreObjectData::OBJECT_NUM.name => Time.now.to_i
    }
    @object_2 = {
      CoreObjectData::OBJECT_NUM.name => Time.now.to_i * 2
    }
    @movement_1 = {
      CoreInventoryMovementData::CURRENT_LOCATION.name => "movement 1"
    }
    @movement_2 = {
      CoreInventoryMovementData::CURRENT_LOCATION.name => "movement 2"
    }
    @movement_3 = {
      CoreInventoryMovementData::CURRENT_LOCATION.name => "movement 3",
      CoreInventoryMovementData::LOCATION_DATE.name => (Date.today - 20).to_s
    }
    @movement_4 = {
      CoreInventoryMovementData::CURRENT_LOCATION.name => "movement 4",
      CoreInventoryMovementData::LOCATION_DATE.name => Date.today.to_s
    }
    @movement_5 = {
      CoreInventoryMovementData::CURRENT_LOCATION.name => "movement 5",
      CoreInventoryMovementData::LOCATION_DATE.name => Date.today.to_s
    }
    @movement_6 = {
      CoreInventoryMovementData::CURRENT_LOCATION.name => "movement 6",
      CoreInventoryMovementData::LOCATION_DATE.name => Date.today.to_s
    }

    @login_page.load_page
    @login_page.log_in(@admin.username, @admin.password)

    [@movement_1, @movement_2, @movement_3, @movement_4, @movement_5, @movement_6].each do |record|
      @test.set_unique_test_id(record, CoreInventoryMovementData::REF_NUM.name)
      @search_page.click_create_new_link
      @create_new_page.click_create_new_movement
      @movement_page.create_unlocked_movement record
    end
  end

  after(:all) { quit_browser @test.driver }

  it "Relate a Cataloging/Object record to a LMI record" do
    @search_page.click_create_new_link
    @create_new_page.click_create_new_object
    @object_page.create_new_object @object_1
    @object_page.click_add_related_procedure
    @object_page.click_dialog_search_button
    @search_results_page.relate_records([@movement_1[CoreInventoryMovementData::REF_NUM.name]])
    @object_page.refresh_page
    @object_page.wait_for_location @movement_1
  end

  it "Update the location of the Movement record" do
    @movement_1[CoreInventoryMovementData::CURRENT_LOCATION.name] = "movement 1a"
    @object_page.expand_sidebar_related_proc
    @object_page.click_sidebar_related_proc(@movement_1[CoreInventoryMovementData::REF_NUM.name])
    @movement_page.enter_location_and_save @movement_1
    @movement_page.expand_sidebar_related_obj
    @movement_page.click_sidebar_related_obj @object_1[CoreObjectData::OBJECT_NUM.name]
    @object_page.refresh_page
    @object_page.wait_for_location @movement_1
  end

  it "Related a new Movement record with the existing Cataloging record" do
    @object_page.click_add_related_procedure
    @object_page.click_dialog_search_button
    @search_results_page.relate_records([@movement_2[CoreInventoryMovementData::REF_NUM.name]])
    @object_page.refresh_page
    expect(@object_page.element_value(@object_page.computed_storage_location)).to be_nil
  end

  it "Relate another new Movement record with the existing Cataloging record" do
    @object_page.click_add_related_procedure
    @object_page.click_dialog_search_button
    @search_results_page.relate_records([@movement_3[CoreInventoryMovementData::REF_NUM.name]])
    @object_page.refresh_page
    @object_page.wait_for_location @movement_3
  end

  it "Relate another a more recent Movement record with the existing Cataloging record" do
    @object_page.click_add_related_procedure
    @object_page.click_dialog_search_button
    @search_results_page.relate_records([@movement_4[CoreInventoryMovementData::REF_NUM.name]])
    @object_page.refresh_page
    @object_page.wait_for_location @movement_4
  end

  it "Update the 'Location date' of a Movement record to be the most recent" do
    @movement_1[CoreInventoryMovementData::LOCATION_DATE.name] = (Date.today + 1).to_s
    @object_page.expand_sidebar_related_proc
    @object_page.click_sidebar_related_proc @movement_1[CoreInventoryMovementData::REF_NUM.name]
    @movement_page.enter_location_date @movement_1
    @movement_page.save_record_only
    @movement_page.expand_sidebar_related_obj
    @movement_page.click_sidebar_related_obj @object_1[CoreObjectData::OBJECT_NUM.name]
    @object_page.refresh_page
    @object_page.wait_for_location @movement_1
  end

  it "Create new Cataloging record and relate it to Movement records without 'Location date' values" do
    @object_page.click_create_new_link
    @create_new_page.click_create_new_object
    @object_page.create_new_object @object_2
    @object_page.click_add_related_procedure
    @object_page.click_dialog_search_button
    @search_results_page.relate_records([@movement_5[CoreInventoryMovementData::REF_NUM.name],
      @movement_6[CoreInventoryMovementData::REF_NUM.name]])
    @object_page.refresh_page
    @object_page.wait_for_location @movement_6
  end

  it "Modify/update one of two related Movement records that have the same 'Location date' value" do
    @movement_5[CoreInventoryMovementData::CURRENT_LOCATION_NOTE.name] = "note update"
    @object_page.expand_sidebar_related_proc
    @object_page.click_sidebar_related_proc @movement_5[CoreInventoryMovementData::REF_NUM.name]
    @movement_page.enter_current_location_note @movement_5
    @movement_page.save_record_only
    @movement_page.expand_sidebar_related_obj
    @movement_page.click_sidebar_related_obj @object_2[CoreObjectData::OBJECT_NUM.name]
    @object_page.refresh_page
    @object_page.wait_for_location @movement_5
  end

end
