#[functionality] numeric fields

require_relative '../spec_helper'

test_run = TestConfig.new
test_data = test_run.numeric_fields_test_data

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
      #loads record category pages
      @acquisition_page = test_run.get_page CoreAcquisitionPage
      @object_page = test_run.get_page CoreObjectPage
      @media_handling_page = test_run.get_page CoreMediaHandlingPage
      @object_exit_page = test_run.get_page CoreObjectExitPage
      @valuation_control_page = test_run.get_page CoreValuationControlPage

      #set up a record for each record type to ensure presence of existing file
      @login_page.load_page
      @login_page.log_in("students@cspace.berkeley.edu", "cspacestudents")


      #    @test_object = {
      #      CoreObjectData::OBJECT_NUM.name => "0000000"
      #    }
      #    @search_page.click_create_new_link
      #    @create_new_page.click_create_new_object
      #    @object_page.create_new_object @test_object

      #  @test_acquisition = {
      #    CoreAcquisitionData::ACQUIS_REF_NUM.name => "0000000"
      #  }
      #  @object_page.click_create_new_link
      #    @create_new_page.click_create_new_acquisition
      #  @acquisition_page.create_new_acquisition @test_acquisition

      #   @test_media_handling = {
      #      CoreMediaHandlingData::MEDIA_ID_NUM.name => "0000000"
      #    }
      #    @search_page.click_create_new_link
      #    @create_new_page.click_create_new_media_handling
      #    @media_handling_page.create_new_media @test_media_handling

      #    @test_object_exit = {
      #      CoreObjectExitData::OBJECT_EXIT_NUM.name => "0000000"
      #    }
      #      @media_handling_page.click_create_new_link
      #    @create_new_page.click_create_new_object_exit
      #    @object_exit_page.create_new_object_exit @test_object_exit

      #    @test_valuation_control = {
      #      CoreValuationControlData::VC_REF_NUM.name => "0000000"
      #    }
      ##    @object_exit_page.click_create_new_link
      #    @create_new_page.click_create_new_valuation_control
      #    @valuation_control_page.create_new_valuation_control @test_valuation_control
    end


    after(:all) { quit_browser test_run.driver }


    valid_floats = [".1234", "0.1234", "1234.0", "1234", "0", "-9.123"]
    invalid_floats = ["123a", "0.123a", "123.123.123"]
    valid_integers = ["1234", "0", "-1234"]
    invalid_integers = ["123.0", "1abc"]
    multiple_invalid = ["123.0", "123.123.123"]
    it "checks for valid float field inputs" do
      test_data.each do |type, field|
        #sets (type,field) pair to test; will cycle through all pairs for given type (Acquisition, Cataloging, etc)
        @record_type_string = type
        puts @record_type_string
        #finds type page
        @page = test_run.find_page_class(type)
        #loads search link and searches for first entry of record type
        @page.click_search_link

        #search for first present entry of record type
        @search_page.select_record_type_option(@record_type_string)
        @search_page.click_search_button
        @search_results_page.wait_for_results
        @search_results_page.click_result(0)

        field.each do |field|
          puts field
          #locates field and tests for input: ".1234"
          input_field = @page.input_locator([], input_data_name = field)
          if type == 'Objects'
            if field == 'value' and !(@page.exists? input_field)
              test_run.driver.find_element(:xpath => "//button//h3//span[text() = 'Object Description Information']").click
            elsif field == 'ownershipExchangePriceValue' and !(@page.exists? input_field)
              test_run.driver.find_element(:xpath => "//span[text() = 'Object History and Association Information']").click
            end
          elsif type == "Object Exits" and !(@page.exists? input_field)
            test_run.driver.find_element(:xpath => "//span[text()= 'Deaccession and Disposal Information']").click
          end
          @page.scroll_to_element(input_field)
          valid_floats.each do |float|
            #test for input

            @page.wait_for_element_and_type(input_field, float)
            @page.save_record
            #checks if save was successful
            #  @page.wait_for_notification("Saving")
          #  @page.wait_for_notification("Saved")
            success_message = @page.element_text(:xpath => '//div[@class = "cspace-ui-RecordHistory--common"]')
            expect(success_message.include? "Editing").to be false
            @page.close_notifications_bar
          end
        end
      end
    end

    it "checks for invalid float field inputs" do
      test_data.each do |type, field|
        #sets (type,field) pair to test; will cycle through all pairs for given type (Acquisition, Cataloging, etc)
        @record_type_string = type
        puts @record_type_string
        #finds type page
        @page = test_run.find_page_class(type)
        #loads search link and searches for first entry of record type
        @page.click_search_link
        #search for first present entry of record type
        @search_page.select_record_type_option(@record_type_string)
        @search_page.click_search_button
        @search_results_page.wait_for_results
        @search_results_page.click_result(0)

      #  @page.unhide_notifications_bar
        field.each do |field|
          puts field
          input_field = @page.input_locator([], input_data_name = field)
          if type == 'Objects'
            puts @page.exists? input_field
            if field == 'value' and !(@page.exists? input_field)
              test_run.driver.find_element(:xpath => "//button//h3//span[text() = 'Object Description Information']").click
            elsif field == 'ownershipExchangePriceValue' and !(@page.exists? input_field)
              puts "OPENED BANNER"
              test_run.driver.find_element(:xpath => "//span[text() = 'Object History and Association Information']").click
            end
          elsif type == "Object Exits" and !(@page.exists? input_field)
            puts "OPENED OE BANNER"
            test_run.driver.find_element(:xpath => "//span[text()= 'Deaccession and Disposal Information']").click
          end
          #test for invalid_floats inputs to field
          invalid_floats.each do |float|
            @page.scroll_to_element(input_field)
            @page.wait_for_element_and_type(input_field, float)
            @page.hit_enter
            #checks for error notification message
            notifications = @page.element_text(:xpath => '//div[@class="cspace-ui-NotificationBar--common"]//div')

            expect(notifications.include? " must be a number. Correct the value").to be true
            #checks that clicking save is disabled
            save_button = test_run.driver.find_element(:name => 'save')
            expect(save_button.enabled?).to be false
            #reverts changes
            @page.revert_record
          end
        end
      end
    end

    it "checks for valid integer inputs" do
    #  test_run.get_page CoreSearchPage
     @search_page.click_search_link
      @search_page.select_record_type_option("Objects")
      @search_page.click_search_button
      @search_results_page.wait_for_results
      @search_results_page.click_result(0)
        ["numberOfObjects", "age"].each do |field|
        input_field = @object_page.input_locator([], input_data_name = field)
        puts input_field
        valid_integers.each do |int|
          if !(@object_page.exists? input_field)
            test_run.driver.find_element(:xpath => "//button//h3//span[text() = 'Object Description Information']").click
          end
          @object_page.scroll_to_element(input_field)
          @object_page.wait_for_element_and_type(input_field, int)
          @object_page.save_record
      #    @object_page.click_save_button
          #checks if save was successful
          #  @page.wait_for_notification("Saving")
          #  @page.wait_for_notification("Saved")
          #  sleep Config.click_wait
          success_message = test_run.driver.find_element(:xpath => '//div[@class = "cspace-ui-RecordHistory--common"]')
          #  @page.when_exists(success_message)
          expect(success_message.text.include? "Editing").to be false
          @object_page.close_notifications_bar
        end
      end
    end

    it "checks for invalid integer field inputs" do
      @search_page.click_search_link
      @search_page.select_record_type_option("Objects")
      @search_page.click_search_button
      @search_results_page.wait_for_results
      @search_results_page.click_result(0)
      ["numberOfObjects", "age"].each do |field|
      input_field = @object_page.input_locator([], input_data_name = field)
      invalid_integers.each do |int|
        if !(@object_page.exists? input_field)
          test_run.driver.find_element(:xpath => "//button//h3//span[text() = 'Object Description Information']").click
        end
        @object_page.scroll_to_element(input_field)
        @object_page.wait_for_element_and_type(input_field, int)
        @object_page.unhide_notifications_bar
        @object_page.hit_enter
        #checks for error notification message
        notifications = @object_page.element_text(:xpath => '//div[@class="cspace-ui-NotificationBar--common"]//div')
        puts notifications
        expect(notifications.include? "must be an integer. Correct the value").to be true
        #checks that clicking save is disabled
        save_button = test_run.driver.find_element(:name => 'save')
        expect(save_button.enabled?).to be false
        #reverts changes
        @object_page.revert_record
      end
    end
    end
    
    it "checks for multiple invalid fields" do
      @search_page.click_search_link
      @search_page.select_record_type_option("Objects")
      @search_page.click_search_button
      @search_results_page.wait_for_results
      @search_results_page.click_result(0)
      #@object_page.unhide_notifications_bar
      ["numberOfObjects", "age"].each do |field|
        input_field = @object_page.input_locator([], input_data_name = field)
        multiple_invalid.each do |int|
          if !(@object_page.exists? input_field)
            test_run.driver.find_element(:xpath => "//button//h3//span[text() = 'Object Description Information']").click
          end
          @object_page.scroll_to_element(input_field)
          @object_page.wait_for_element_and_type(input_field, int)
          @object_page.hit_enter
          #checks for error notification message
          notifications = @object_page.element_text(:xpath => '//div[@class="cspace-ui-NotificationBar--common"]//div')
          puts notifications
          expect(notifications.include? "must be an integer. Correct the value").to be true
          #checks that clicking save is disabled
        end
        save_button = test_run.driver.find_element(:name => 'save')
        expect(save_button.enabled?).to be false
        save_notifications = @object_page.element_text(:xpath => '//div[@class="cspace-ui-NotificationBar--common"]//div')
        puts save_notifications
        expect(save_notifications.include? "Number of objects must be an integer. Correct the value").to be true
        expect(save_notifications.include? "Age value must be an integer. Correct the value").to be true
        #reverts changes
        @object_page.revert_record
      end
    end




  end
end
