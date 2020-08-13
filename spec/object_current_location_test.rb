require_relative '../spec_helper'

test_run = TestConfig.new

if test_run.deployment == Deployment::CORE

  describe 'CollectionSpace' do

    include Logging
    include WebDriverManager

    before(:all) do
      test_run.set_driver launch_browser
      @admin = test_run.get_admin_user
      @login_page = test_run.get_page CoreLoginPage
      @create_new_page = test_run.get_page CoreCreateNewPage
      @search_page = test_run.get_page CoreSearchPage
      @search_results_page = test_run.get_page CoreSearchResultsPage
      @object_page = test_run.get_page CoreObjectPage
      @inventory_movement_page = test_run.get_page CoreInventoryMovementPage
      @login_page.load_page
      @login_page.log_in(@admin.username, @admin.password)
    end

    after(:all) { quit_browser test_run.driver }

    proc_alpha = {:xpath => '//div[@aria-colindex = "2"][@title = "Alpha Location"]'}
    proc_bravo = {:xpath => '//div[@aria-colindex = "2"][@title = "Bravo Location"]'}
    proc_charlie = {:xpath => '//div[@aria-colindex = "2"][@title = "Charlie Organization"]'}
    terms_alpha = {:xpath => '//div[@aria-colindex = "1"][@title ="Alpha Location"]'}
    terms_bravo = {:xpath => '//div[@aria-colindex = "1"][@title ="Bravo Location"]'}
    terms_charlie = {:xpath => '//div[@aria-colindex = "1"][@title = "Charlie Organization"]'}

    it "Object Current Location is Created/Updated - Test 1a" do
      @search_page.click_create_new_link
      @create_new_page.click_create_new_object
      tango_object = {
        CoreObjectData::TITLE_GRP.name => [
          {
            CoreObjectData::TITLE.name => "Tango Object"
          }
        ]
      }
      test_run.set_unique_test_id(tango_object, CoreObjectData::OBJECT_NUM.name)
      @object_page.create_new_object tango_object
      @object_page.scroll_to_top
      @object_page.select_related_type "Location/Movement/Inventory"
      @object_page.click_create_new_button

      alpha_location_lmi = {
        CoreInventoryMovementData::CURRENT_LOCATION.name => "Alpha Location",
        CoreInventoryMovementData::LOCATION_DATE.name => "1700-01-01"
      }
      test_run.set_unique_test_id(alpha_location_lmi, CoreInventoryMovementData::REF_NUM.name)
      @inventory_movement_page.enter_reference_number alpha_location_lmi
      @inventory_movement_page.hit_tab
      current_location_input = @inventory_movement_page.input_locator([], CoreInventoryMovementData::CURRENT_LOCATION.name)
      current_location_options = @inventory_movement_page.input_options_locator([], CoreInventoryMovementData::CURRENT_LOCATION.name)
      @inventory_movement_page.scroll_to_element(current_location_input)
      @inventory_movement_page.enter_auto_complete(current_location_input, current_location_options, "Alpha Location", 'Offsite Storage Locations')
      @inventory_movement_page.enter_location_date alpha_location_lmi
      @inventory_movement_page.save_record_only

      @inventory_movement_page.quick_search("Objects", [], "Tango Object")
      @search_results_page.click_result(0)

      test_run.driver.navigate.refresh
      @object_page.expand_sidebar_related_proc
      expect(@object_page.exists? proc_alpha).to be true
      expect(CoreObjectData::COMPUTED_LOCATION.name).eql? "Alpha Location"
      @object_page.expand_sidebar_terms_used
      sleep Config.click_wait
      expect(@object_page.exists? terms_alpha).to be true
    end

    it "Object Current Location is Created/Updated - Test 1b" do
      @search_page.click_create_new_link
      @create_new_page.click_create_new_movement
      bravo_location = {
        CoreInventoryMovementData::CURRENT_LOCATION.name => "Bravo Location",
        CoreInventoryMovementData::LOCATION_DATE.name => "1800-01-01"
      }
      test_run.set_unique_test_id(bravo_location, CoreInventoryMovementData::REF_NUM.name)
      @inventory_movement_page.enter_reference_number bravo_location
      @inventory_movement_page.hit_tab
      current_location_input = @inventory_movement_page.input_locator([], CoreInventoryMovementData::CURRENT_LOCATION.name)
      current_location_options = @inventory_movement_page.input_options_locator([], CoreInventoryMovementData::CURRENT_LOCATION.name)
      @inventory_movement_page.scroll_to_element(current_location_input)
      @inventory_movement_page.enter_auto_complete(current_location_input, current_location_options, "Bravo Location", 'Offsite Storage Locations')
      @inventory_movement_page.enter_location_date bravo_location
      @inventory_movement_page.save_record_only

      @inventory_movement_page.quick_search("Objects", [], "Tango Object")
      @search_results_page.click_result(0)

      @object_page.click_add_related_procedure
      dropdown_input = {:xpath => '//div[contains(@class,"SearchFormRecordType")]//input'}
      dropdown_options = {:xpath => '//div[@class = "cspace-layout-Popup--common"]//li' }
      @object_page.wait_for_options_and_select(dropdown_input, dropdown_options, "Location/Movement/Inventory")
      keywords_input_locator = {:xpath => '//label[text()="Keywords"]/following-sibling::input'}
      @object_page.wait_for_element_and_type(keywords_input_locator, "Bravo")
      test_run.driver.find_element(:xpath => '//footer//button[@name = "search"]').click
      @object_page.wait_for_element_and_click(:xpath => "//div[@class=\"cspace-ui-SearchResultTable--common\"]//div[@aria-label=\"row\"][contains(.,'Bravo')]//input")
      test_run.driver.find_element(:name => "accept").click

      @object_page.expand_sidebar_related_proc
      expect(@object_page.exists?(proc_bravo) && @object_page.exists?(proc_alpha)).to be true
      expect(CoreObjectData::COMPUTED_LOCATION.name).eql? "Alpha Location"
      @object_page.expand_sidebar_terms_used
      sleep Config.click_wait
      expect(@object_page.exists? terms_alpha).to be true

      test_run.driver.navigate.refresh

      expect(CoreObjectData::COMPUTED_LOCATION.name).eql? "Bravo Location"
      @object_page.expand_sidebar_terms_used
      sleep Config.click_wait
      expect(@object_page.exists? terms_bravo).to be true
    end

    it "Object Current Location is Created/Updated - Test 1c" do
      @object_page.click_create_new_link
      @create_new_page.click_create_new_movement
      charlie_org = {
        CoreInventoryMovementData::CURRENT_LOCATION.name => "Charlie Organization",
        CoreInventoryMovementData::LOCATION_DATE.name => "1900-01-01"
      }
      test_run.set_unique_test_id(charlie_org, CoreInventoryMovementData::REF_NUM.name)
      @inventory_movement_page.enter_reference_number charlie_org
      @inventory_movement_page.hit_tab
      current_location_input = @inventory_movement_page.input_locator([], CoreInventoryMovementData::CURRENT_LOCATION.name)
      current_location_options = @inventory_movement_page.input_options_locator([], CoreInventoryMovementData::CURRENT_LOCATION.name)
      @inventory_movement_page.scroll_to_element(current_location_input)
      @inventory_movement_page.enter_auto_complete(current_location_input, current_location_options, "Charlie Organization", 'Local Organizations')
      @inventory_movement_page.enter_location_date charlie_org
      @inventory_movement_page.save_record_only

      @inventory_movement_page.quick_search("Objects", [], "Tango Object")
      @search_results_page.click_result(0)

      test_run.driver.find_element(:xpath => '//button[@data-recordtype ="movement"]').click
      @object_page.wait_for_element_and_click(:name => 'relate')
      keywords_input_locator = {:xpath => '//label[text()="Keywords"]/following-sibling::input'}
      @object_page.wait_for_element_and_type(keywords_input_locator, "Charlie")
      test_run.driver.find_element(:xpath => '//footer//button[@name = "search"]').click
      @object_page.wait_for_element_and_click(:xpath => "//div[@class=\"cspace-ui-SearchResultTable--common\"]//div[@aria-label=\"row\"][contains(.,'Charlie Organization')]//input")
      test_run.driver.find_element(:name => "accept").click
      test_run.driver.find_element(:xpath => '//button[contains(.,"Primary Record")]').click

      @object_page.expand_sidebar_related_proc
      expect(@object_page.exists?(proc_charlie) && @object_page.exists?(proc_bravo) && @object_page.exists?(proc_alpha)).to be true
      expect(CoreObjectData::COMPUTED_LOCATION.name).eql? "Bravo Location"
      @object_page.expand_sidebar_terms_used
      sleep Config.click_wait
      expect(@object_page.exists? terms_bravo).to be true

      test_run.driver.navigate.refresh

      expect(CoreObjectData::COMPUTED_LOCATION.name).eql? "Charlie Organization"
      @object_page.expand_sidebar_terms_used
      sleep Config.click_wait
      expect(@object_page.exists? terms_charlie).to be true
    end

    it "Object Current Location is Created/Updated - Test 2" do
      @object_page.quick_search("Location/Movement/Inventory", [], "Alpha Location")
      @search_results_page.click_result(0)
      location_date = @inventory_movement_page.input_locator([], 'locationDate')
      @inventory_movement_page.wait_for_element_and_type(location_date, "2000-01-01")
      @inventory_movement_page.hit_enter
      @inventory_movement_page.save_record_only
      @inventory_movement_page.expand_sidebar_related_obj
      test_run.driver.find_element(:xpath => '//*[@aria-colindex = "2"][@title = "Tango Object"]').click

      expect(CoreObjectData::COMPUTED_LOCATION.name).eql? "Alpha Location"
      @object_page.expand_sidebar_terms_used
      test_run.driver.navigate.refresh
      sleep Config.click_wait
      expect(@object_page.exists? terms_alpha).to be true
    end

    it "Object Current Location is Updated When a Related L/M/I is Deleted - Test 3" do
      @object_page.expand_sidebar_related_proc
      test_run.driver.find_element(:xpath => '//*[@aria-colindex = "2"][@title = "Alpha Location"]').click
      @inventory_movement_page.delete_record
      @inventory_movement_page.quick_search("Objects", [], "Tango Object")
      @search_results_page.click_result(0)

      test_run.driver.navigate.refresh
      @object_page.expand_sidebar_related_proc
      num_of_proc = {:xpath => '//span[contains(., "Related Procedures: 2")]'}
      expect(@object_page.exists? num_of_proc).to be true
      expect(@object_page.exists?(proc_charlie) && @object_page.exists?(proc_bravo)).to be true
      expect(CoreObjectData::COMPUTED_LOCATION.name).eql? "Charlie Organization"
      @object_page.expand_sidebar_terms_used
      sleep Config.click_wait
      expect(@object_page.exists? terms_charlie).to be true
    end

    it "Object Current Location is Updated When Relationship to L/M/I is Deleted - Test 4" do
      test_run.driver.find_element(:xpath => '//button[contains(.,"Location/Movement/Inventory")]').click
      @object_page.wait_for_element_and_click(:xpath => '//div[@title = "Charlie Organization"][@aria-colindex = 4]/preceding::input[1]')
      @object_page.unrelate_record
      @object_page.quick_search("Objects", [], "Tango Object")
      @search_results_page.click_result(0)

      test_run.driver.navigate.refresh
      @object_page.expand_sidebar_related_proc
      num_of_proc = {:xpath => '//span[contains(., "Related Procedures: 1")]'}
      expect(@object_page.exists? num_of_proc).to be true
      expect(@object_page.exists? proc_bravo).to be true
      expect(CoreObjectData::COMPUTED_LOCATION.name).eql? "Bravo Location"
      @object_page.expand_sidebar_terms_used
      sleep Config.click_wait
      expect(@object_page.exists? terms_bravo).to be true
    end
  end
end
