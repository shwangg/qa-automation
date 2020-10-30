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
<<<<<<< HEAD
      @acquisition_page = test_run.get_page CoreAcquisitionPage
=======
>>>>>>> c424e634b81e5f22f5601800c4600fa9e8e744bc
      @create_new_page = test_run.get_page CoreCreateNewPage
      @search_page = test_run.get_page CoreSearchPage
      @search_results_page = test_run.get_page CoreSearchResultsPage
      @object_page = test_run.get_page CoreObjectPage
<<<<<<< HEAD
      @person_auth_page = test_run.get_page CorePersonPage

      @login_page.load_page
      @login_page.log_in(@admin.username, @admin.password)
=======

#      empty_menu = {:xpath => //header[contains(., 'Related Objects')]/following-sibling::div//div[@class = "cspace-ui-SearchResultEmpty--common"]}

      @login_page.load_page
      @login_page.log_in("students@cspace.berkeley.edu", "cspacestudents")
        #@admin.username, @admin.password)
>>>>>>> c424e634b81e5f22f5601800c4600fa9e8e744bc

      @test_1_object = {
        CoreObjectData::OBJECT_NUM.name => Time.now.to_i
      }
      @test_7_object = {
        CoreObjectData::OBJECT_NUM.name => Time.now.to_i * 3
      }
<<<<<<< HEAD
      @Record_A = {
        CoreObjectData::OBJECT_NUM.name => Time.now.to_i * 4,
        CoreObjectData::OBJ_NAME_NAME.name => "Record A"
      }
      @QA_TEST_record = {
        CoreObjectData::OBJECT_NUM.name => "QA TEST"
      }
      @related_obj = {
        CoreObjectData::OBJECT_NUM.name => Time.now.to_i * 6
      }
      @related_proc = {
        CoreAcquisitionData::ACQUIS_REF_NUM.name => Time.now.to_i * 5
      }

      [@QA_TEST_record, @related_proc, @related_obj].each do |record|
        @search_page.click_create_new_link
        if record == @related_proc
          @create_new_page.click_create_new_acquisition
          @acquisition_page.create_new_acquisition record
        else
          @create_new_page.click_create_new_object
          @object_page.create_new_object record
        end
      end
=======

      @QA_TEST_record = {
        CoreObjectData::OBJECT_NUM.name => "QA TEST"
      }

      @relate_object_record = {
        CoreObjectData::OBJECT_NUM.name => Time.now.to_i * 5
      }
      [@QA_TEST_record, @relate_object_record].each do |record|
        @search_page.click_create_new_link
        @create_new_page.click_create_new_object
        @object_page.create_new_object record
      end

      @object_page.hide_notifications_bar

>>>>>>> c424e634b81e5f22f5601800c4600fa9e8e744bc
    end

    after(:all) { quit_browser test_run.driver }

<<<<<<< HEAD
    #variables/methods to be used in tests
    add_row = {:xpath => '(//fieldset[@data-name = "contentPerson"]//div//button)[last()]'}
    dialog_element = {:xpath => "//div[@role = 'dialog']"}
    dialog_record_header = {:xpath => '(//div[@role = "dialog"]//div[contains(@class,"SearchResultSummary")]//span)[1]'}
    editing_button = {:xpath => "//button[contains(., 'Editing')]"}
    header_record_label = {:xpath => "//header//div//h1"}
    records_found_header_text = {:xpath => "//div[contains(@class, 'SearchResultSummary')]//div"}
    related_objects_header = {:xpath => "//section[contains(.,'Related Objects')]//header"}
    notification_time_stamp = {:xpath => '//div[contains(@class, "NotificationBar")]//header'}
    page_size_chooser = {:xpath => '//footer//div[contains(@class, "PageSizeChooser")]'}
    pivot_test_record_id = {:xpath => "//section[contains(.,'Related Objects:')]//a[@role='row'][1]//div[1]"}
    wait_until_bar = {:xpath => '//div[contains(@class, "SelectBar")]'}

    def person_input_locator(index); {:xpath => "(//fieldset[@data-name = 'contentPerson']//input)[#{index}]"} end
    def sidebar_record_text(label, identifier, index)
      @object_page.element_text({:xpath => "//section[contains(., #{label})]//a[contains(., #{identifier})]//div[#{index}]"})
    end
    ##

    it "empty list on a new page" do
      @object_page.hide_notifications_bar
      @search_page.click_create_new_link
      @create_new_page.click_create_new_object
      @object_page.create_new_object @test_1_object
      @object_page.show_sidebar
      expect(@object_page.exists? @object_page.hide_sidebar_button)
      text = @object_page.element_text(related_objects_header)
      expect(text.include? "Related Objects: 0")

      @object_page.expand_sidebar_related_obj
      expect(@object_page.exists? @object_page.empty_sidebar_section("Related Objects"))
    end

    it "checks if possible to add object via dialog" do
      @object_page.click_add_related_object
      expect(@object_page.exists? dialog_element)
      expect(@object_page.exists? @object_page.inactive_page_check)

      @object_page.click_dialog_search_button
      expect(@object_page.enabled? @search_results_page.relate_selected_button).to be false
      @search_results_page.select_result_row(@related_obj[CoreObjectData::OBJECT_NUM.name])
      @object_page.click_relate_selected_button

      @object_page.when_not_exists(dialog_element, Config.short_wait)
      expect(@object_page.exists? dialog_element).to be false
      expect(@object_page.exists? @object_page.related_obj_link(@related_obj[CoreObjectData::OBJECT_NUM.name]))
    end

    it "checks if search functionality works" do
      @object_page.click_add_related_object
      expect(@object_page.exists? dialog_element)
      expect(@object_page.exists? @object_page.inactive_page_check)

      @object_page.wait_for_element_and_type(@search_page.keywords_input_locator, "QA TEST")
      @object_page.click_dialog_search_button
      expect(@object_page.elements(@search_results_page.result_rows).length() > 0)
      @object_page.click_close_button
    end

=begin
    [20, 40].each do |variation|
      it "checks if the pages work in dialog - select #{variation}" do
        @object_page.click_create_new_link
        @create_new_page.click_create_new_object
        @object_page.create_new_object @test_7_object
        @object_page.click_add_related_object
        @search_page.click_modal_clear_button
        @object_page.click_dialog_search_button

        @object_page.when_exists(wait_until_bar, Config.click_wait)
        expect(/1(–)\d+ of [1-9]\d+ records found/ =~ @object_page.element_text(dialog_record_header)).to be 0
        expect(@object_page.element_value(@search_results_page.footer_select_size_input_locator).to_i >= 0)
        expect(@object_page.element_text(page_size_chooser) == "per page")

        @object_page.scroll_to_element(@search_results_page.footer_select_size_input_locator)
        @search_results_page.select_size(@search_results_page.footer_select_size_input_locator, variation)
        expect(@object_page.element_value(@search_results_page.footer_select_size_input_locator).to_i == variation)
        expect(@object_page.elements(@search_results_page.result_rows).length() == variation)
        expect(@object_page.exists? @search_results_page.navigation_pages)

        @object_page.wait_for_element_and_click(@search_results_page.navigation_right_arrow)
        expect(@object_page.enabled? @search_results_page.navigation_page_index_button(3)).to be false

        @object_page.wait_for_element_and_click(@search_results_page.navigation_page_index_button("last()".gsub('"', '')))
        expect(@object_page.enabled? @search_results_page.navigation_page_index_button("last()".gsub('"', ''))).to be false
        expect(@object_page.enabled? @search_results_page.navigation_right_arrow).to be false

        @object_page.wait_for_element_and_click(@search_results_page.navigation_left_arrow)
        expect(@object_page.enabled? @search_results_page.navigation_page_index_button("last()-1".gsub('"', ''))).to be false

        @object_page.wait_for_element_and_click(@search_results_page.navigation_page_index_button(1))
        expect(@object_page.enabled? @search_results_page.navigation_page_index_button(1)).to be false
        expect(@object_page.enabled? @search_results_page.navigation_left_arrow).to be false
        if variation == 20
          @object_page.click_close_button
        end
      end
    end
=end

    it "test adding multiple to current record from dialog" do
      ##RUN SECTION ONLY IF PRECEDING DIALOG TEST IS COMMENTED OUT - REMOVE WHEN FIXED##
        @object_page.click_create_new_link
        @create_new_page.click_create_new_object
        @object_page.create_new_object @test_7_object
        @object_page.click_add_related_object
        @search_page.click_modal_clear_button
        @object_page.click_dialog_search_button
      ######################END#####################################

      relate_1 = @search_results_page.select_result_nth_row(3)
      @object_page.wait_for_element_and_click(@search_results_page.navigation_right_arrow)
      relate_2 = @search_results_page.select_result_nth_row(2)
      @object_page.click_relate_selected_button

      @object_page.when_not_exists(dialog_element, Config.short_wait)
      expect(@object_page.exists? dialog_element).to be false
      expect(@object_page.exists? @object_page.related_obj_link(relate_1))
      expect(@object_page.exists? @object_page.related_obj_link(relate_2))
      expect(@object_page.element_text(related_objects_header).include? "Related Objects: 2")
    end

    it "test pivoting" do
      pivot_record_id = @object_page.element_text(pivot_test_record_id)
      @object_page.wait_for_element_and_click(pivot_test_record_id)
      expect(@object_page.element_text(header_record_label).include? pivot_record_id)
    end

    it "test correct display of summary in object records" do
      @object_page.click_create_new_link
      @create_new_page.click_create_new_object
      @object_page.create_new_object @Record_A
      time_stamp_A = @object_page.element_text(notification_time_stamp)
      @object_page.click_add_related_object
      @object_page.click_dialog_search_button
      @search_results_page.select_result_row(@related_obj[CoreObjectData::OBJECT_NUM.name])
      @object_page.click_relate_selected_button
      @object_page.click_sidebar_related_obj(@related_obj[CoreObjectData::OBJECT_NUM.name])

      record_A_row = @object_page.related_obj_link(@Record_A[CoreObjectData::OBJECT_NUM.name])
      expect(@object_page.exists? record_A_row)
      expect(sidebar_record_text("Related Objects", @Record_A[CoreObjectData::OBJECT_NUM.name], 1) == @Record_A[CoreObjectData::OBJECT_NUM.name])
      expect(sidebar_record_text("Related Objects", @Record_A[CoreObjectData::OBJECT_NUM.name], 2) == "Record A")
      expect(sidebar_record_text("Related Objects", @Record_A[CoreObjectData::OBJECT_NUM.name], 3) == time_stamp_A)

      @object_page.wait_for_element_and_click(pivot_test_record_id)
      input_loc = @object_page.input_locator([],'title')
      @object_page.wait_for_element_and_type(input_loc, "Title A")
      @object_page.save_record
      time_stamp_A = @object_page.element_text(notification_time_stamp)
      @object_page.click_sidebar_related_obj(@related_obj[CoreObjectData::OBJECT_NUM.name])

      expect(@object_page.exists? record_A_row)
      expect(sidebar_record_text("Related Objects", @Record_A[CoreObjectData::OBJECT_NUM.name], 1) == @Record_A[CoreObjectData::OBJECT_NUM.name])
      expect(sidebar_record_text("Related Objects", @Record_A[CoreObjectData::OBJECT_NUM.name], 2) == "Record A")
      expect(sidebar_record_text("Related Objects", @Record_A[CoreObjectData::OBJECT_NUM.name], 3) == time_stamp_A)
    end

    it "test correct display of summary in procedural records" do
      test_run.set_unique_test_id(@Record_A, CoreObjectData::OBJECT_NUM.name)
      @object_page.click_create_new_link
      @create_new_page.click_create_new_object
      @object_page.create_new_object @Record_A
      time_stamp_A = @object_page.element_text(notification_time_stamp)
      @object_page.click_add_related_procedure
      @object_page.click_dialog_search_button
      @search_results_page.select_result_row(@related_proc[CoreAcquisitionData::ACQUIS_REF_NUM.name])
      @object_page.click_relate_selected_button
      @object_page.expand_sidebar_related_proc
      @object_page.click_sidebar_related_proc(@related_proc[CoreAcquisitionData::ACQUIS_REF_NUM.name])

      record_A_row = @acquisition_page.related_obj_link(@Record_A[CoreObjectData::OBJECT_NUM.name])
      expect(@acquisition_page.exists? record_A_row)
      expect(sidebar_record_text("Related Objects", @Record_A[CoreObjectData::OBJECT_NUM.name], 1) == @Record_A[CoreObjectData::OBJECT_NUM.name])
      expect(sidebar_record_text("Related Objects", @Record_A[CoreObjectData::OBJECT_NUM.name], 2) == "Record A")
      expect(sidebar_record_text("Related Objects", @Record_A[CoreObjectData::OBJECT_NUM.name], 3) == time_stamp_A)

      @acquisition_page.expand_sidebar_related_obj
      @acquisition_page.wait_for_element_and_click(pivot_test_record_id)
      title_input = @object_page.input_locator([],'title')
      @object_page.wait_for_element_and_type(title_input, "Title A")
      @object_page.save_record
      time_stamp_A = @object_page.element_text(notification_time_stamp)
      @object_page.click_sidebar_related_proc(@related_proc[CoreAcquisitionData::ACQUIS_REF_NUM.name])

      expect(@acquisition_page.exists? record_A_row)
      expect(sidebar_record_text("Related Objects", @Record_A[CoreObjectData::OBJECT_NUM.name], 1) == @Record_A[CoreObjectData::OBJECT_NUM.name])
      expect(sidebar_record_text("Related Objects", @Record_A[CoreObjectData::OBJECT_NUM.name], 2) == "Record A")
      expect(sidebar_record_text("Related Objects", @Record_A[CoreObjectData::OBJECT_NUM.name], 3) == time_stamp_A)
    end

    it "test correct display of summary on authority pages" do
      test_run.set_unique_test_id(@Record_A, CoreObjectData::OBJECT_NUM.name)
      @object_page.click_create_new_link
      @create_new_page.click_create_new_object
      @object_page.enter_object_number(@Record_A)
      @object_page.scroll_to_element(@object_page.object_name_input(0))
      @object_page.wait_for_element_and_type(@object_page.object_name_input(0), "Name A")
      @object_page.uncollapse_panel_if_collapsed("Object Description Information")
      @object_page.uncollapse_subpanel_if_collapsed("Content")
      @object_page.scroll_to_element(person_input_locator(1))
      person_input_options = @object_page.input_options_locator([@object_page.fieldset("contentPerson")])
      @object_page.enter_auto_complete(person_input_locator(1), person_input_options, "Person A", 'Local Persons')
      @object_page.wait_for_element_and_click(add_row)
      @object_page.enter_auto_complete(person_input_locator(2), person_input_options, "Person B", 'Local Persons')
      @object_page.save_record
      @object_page.expand_sidebar_terms_used
      @object_page.click_sidebar_term("Person A")

      expect(@person_auth_page.element_text(header_record_label) == "Person A")
      @person_auth_page.expand_sidebar_used_by
      expect(@person_auth_page.exists? @person_auth_page.used_by_link(@Record_A[CoreObjectData::OBJECT_NUM.name]))
      expect(sidebar_record_text("Used By", @Record_A[CoreObjectData::OBJECT_NUM.name], 1) == @Record_A[CoreObjectData::OBJECT_NUM.name])
      expect(sidebar_record_text("Used By", @Record_A[CoreObjectData::OBJECT_NUM.name], 2) == "Name A")
      expect(sidebar_record_text("Used By", @Record_A[CoreObjectData::OBJECT_NUM.name], 4) == "Content person")

      @person_auth_page.click_sidebar_used_by(@Record_A[CoreObjectData::OBJECT_NUM.name])
      @object_page.wait_for_element_and_type(@object_page.input_locator([],'title'), "Title A")
      @object_page.save_record
      @object_page.click_sidebar_term("Person A")

      expect(@person_auth_page.exists? @person_auth_page.used_by_link(@Record_A[CoreObjectData::OBJECT_NUM.name]))
      expect(sidebar_record_text("Used By", @Record_A[CoreObjectData::OBJECT_NUM.name], 1) == @Record_A[CoreObjectData::OBJECT_NUM.name])
      expect(sidebar_record_text("Used By", @Record_A[CoreObjectData::OBJECT_NUM.name], 2) == "Title A")
      expect(sidebar_record_text("Used By", @Record_A[CoreObjectData::OBJECT_NUM.name], 4) == "Content person")
      @person_auth_page.click_sidebar_used_by(@Record_A[CoreObjectData::OBJECT_NUM.name])
    end

    it "test if the close button works" do
      @object_page.click_add_related_object
      @object_page.click_close_button
      expect(@object_page.exists? dialog_element).to be false
      expect(@object_page.exists? editing_button).to be false
    end

    it "test if the close button works using Esc key" do
      @object_page.click_add_related_object
      @object_page.hit_escape
      @object_page.when_not_exists(dialog_element, Config.short_wait)
      expect(@object_page.exists? dialog_element).to be false
      expect(@object_page.exists? editing_button).to be false
    end

    it "test adding a relation to self" do
      @object_page.click_add_related_object
      @search_page.enter_keyword(@Record_A[CoreObjectData::OBJECT_NUM.name])
      @search_page.click_search_button
      expect(@search_results_page.row_exists?(@Record_A[CoreObjectData::OBJECT_NUM.name]))
      expect(@search_results_page.exists? @search_results_page.result_row_checkbox(@Record_A[CoreObjectData::OBJECT_NUM.name])).to be false
      @object_page.click_close_button
    end

    it "test adding multiple copies of a record" do
      @object_page.hide_notifications_bar
      @object_page.click_add_related_object
      @search_page.click_modal_clear_button
      @search_page.click_search_button
      @search_results_page.select_result_row(@related_obj[CoreObjectData::OBJECT_NUM.name])
      @search_results_page.click_relate_selected_button
      @object_page.when_not_exists(dialog_element, Config.short_wait)
      expect(@object_page.exists? dialog_element).to be false
      expect(@object_page.exists? @object_page.related_obj_link(@related_obj[CoreObjectData::OBJECT_NUM.name]))

      @object_page.click_add_related_object
      @search_page.click_search_button
      expect(@search_results_page.row_exists?(@related_obj[CoreObjectData::OBJECT_NUM.name]))
      expect(@search_results_page.exists? @search_results_page.result_row_checkbox(@related_obj[CoreObjectData::OBJECT_NUM.name])).to be false
    end
=======
    #def variables to be used in tests
    related_objects_header = {:xpath => "//section[contains(.,'Related Objects')]//header"}
    dialog_element = {:xpath => "//div[@role = 'dialog']"}
    records_found_header_text = {:xpath => "//div[contains(@class, 'SearchResultSummary')]//div"}

    wait_until_bar = {:xpath => '//div[contains(@class, "SelectBar")]'}
    dialog_record_header = {:xpath => '(//div[@role = "dialog"]//div[contains(@class,"SearchResultSummary")]//span)[1]'}

    it "empty list on a new page" do
      @search_page.click_create_new_link
      @create_new_page.click_create_new_object
        @object_page.create_new_object @test_1_object
        @object_page.show_sidebar
        expect(@object_page.exists? @object_page.hide_sidebar_button)
        text = @object_page.element_text(related_objects_header)
        expect(text.include? "Related Objects: 0")
        @object_page.expand_sidebar_related_obj
        expect(@object_page.exists? @object_page.empty_sidebar_section("Related Objects"))
       end

       it "checks if possible to add object via dialog" do
         @object_page.click_add_related_object
         expect(@object_page.exists? dialog_element)
         expect(@object_page.exists? @object_page.inactive_page_check)
         @object_page.click_dialog_search_button
         expect(@object_page.enabled? @search_results_page.relate_selected_button).to be false
         @search_results_page.select_result_row(@relate_object_record[CoreObjectData::OBJECT_NUM.name])
         @search_results_page.wait_for_element_and_click(@search_results_page.relate_selected_button)
       @object_page.when_not_exists(dialog_element, Config.short_wait)
       expect(@object_page.exists? dialog_element).to be false
       expect(@object_page.exists? @object_page.related_obj_link(@relate_object_record[CoreObjectData::OBJECT_NUM.name]))
##check
     end

     it "checks if search functionality works" do
       @object_page.click_add_related_object
       expect(@object_page.exists? dialog_element)
       expect(@object_page.exists? @object_page.inactive_page_check)
       @object_page.wait_for_element_and_type(@search_page.keywords_input_locator, "QA TEST")
       @object_page.click_dialog_search_button
       expect(@object_page.elements(@search_results_page.result_rows).length() > 0)
       @object_page.click_close_button
     end

     [20, 40].each do |variation|
       it "checks if the pages work in dialog - select #{variation}" do
         @object_page.click_create_new_link
         @create_new_page.click_create_new_object
         @object_page.create_new_object @test_7_object
         @object_page.click_add_related_object
         ##clear keywords search bar
         @object_page.element(@search_page.keywords_input_locator).clear
         @object_page.click_dialog_search_button

         @object_page.when_exists(wait_until_bar, Config.click_wait)

         expect(/1(–)\d+ of [1-9]\d+ records found/ =~ @object_page.element_text(dialog_record_header)).to be 0

      #   num_per_page_value = {:xpath => '//div[@role = "dialog"]//footer//input'}

         expect(@object_page.element_value(@search_results_page.footer_select_size_input_locator).to_i >= 0)
         expect(@object_page.element_text(:xpath => '//footer//div[contains(@class, "PageSizeChooser")]') == "per page")

         ## re run test above; internet was not working
         #actions: variations
         @object_page.scroll_to_element(@search_results_page.footer_select_size_input_locator)
         @search_results_page.select_size(@search_results_page.footer_select_size_input_locator, variation)
         ##{variation} records should be shown and the bottom of the list should show
         #### the total number of search results pages

         expect(@object_page.element_value(@search_results_page.footer_select_size_input_locator).to_i == variation)
         expect(@object_page.elements(@search_results_page.result_rows).length() == variation)
         expect(@object_page.exists? @search_results_page.navigation_pages)

         ##click < > arrows next to search results pages should take you to the next and previous pages
         @object_page.wait_for_element_and_click(@search_results_page.navigation_right_arrow)
        # expect(@object_page.enabled? @search_results_page.navigation_page_index_button(2)).to be false
        page_2_alt = {:xpath => '//footer//nav//ul//button[@data-pagenum = "1"]'}
        expect(@object_page.enabled? page_2_alt)
        puts (@object_page.element_text(page_2_alt))
        puts (@object_page.enabled? @search_results_page.navigation_page_index_button(2))
        puts @object_page.element_text(@search_results_page.navigation_page_index_button(2))
      #  puts expect(@search_results_page.navigation_page_index_button(2))
        #new plan: pg 2 -> last page (check disabled > arrow) -> move left < to last() -1 page -> first page (check disabled < arrow)
#last page
        @object_page.wait_for_element_and_click(@search_results_page.navigation_page_index_button("last()".gsub('"', '')))
        expect(@object_page.enabled? @search_results_page.navigation_page_index_button("last()".gsub('"', ''))).to be false
        expect(@object_page.enabled? @search_results_page.navigation_right_arrow).to be false
#move left to last() -1
        alt_leftarrow = {:xpath => '//footer//nav//ul/preceding-sibling::button'}
        puts (@object_page.enabled? @search_results_page.navigation_left_arrow)
        puts (@object_page.enabled? alt_leftarrow)
        puts (@object_page.exists? alt_leftarrow)
        puts (@object_page.element_text(alt_leftarrow))
      #  @object_page.wait_for_element_and_click(@search_results_page.navigation_left_arrow)
        @object_page.click_element(alt_leftarrow)
    #    @object_page.click_element(@search_results_page.navigation_left_arrow)
        expect(@object_page.enabled? @search_results_page.navigation_page_index_button("last()-1".gsub('"', ''))).to be false
#move back to first page
        @object_page.wait_for_element_and_click(@search_results_page.navigation_page_index_button(1))
        expect(@object_page.enabled? @search_results_page.navigation_page_index_button(1)).to be false
        expect(@object_page.enabled? @search_results_page.navigation_left_arrow)



##stuck below: all buttons other thatn > arrow registering as disabled



        #  @object_page.when_enabled(@search_results_page.navigation_left_arrow, Config.short_wait)
          puts (@object_page.enabled? @search_results_page.navigation_left_arrow)

         @object_page.click_element(@search_results_page.navigation_left_arrow)
         expect(@object_page.enabled? @search_results_page.navigation_page_index_button(1)).to be false
         ##if you are at the first page or last page, the next and previous links, respectively, should be disabled
         expect(@object_page.enabled? @search_results_page.navigation_left_arrow).to be false
                #move to last
         @object_page.wait_for_element_and_type(@search_results_page.navigation_page_button(last()))
         expect(@object_page.enabled? @search_results_page.navigation_page_index_button(last())).to be false
         expect(@object_page.enabled? @search_results_page.navigation_right_arrow).to be false
        ##clicking the numbers should take you directly to that page of results
        @object_page.wait_for_element_and_type(@search_results_page.navigation_page_button(1))
        expect(@object_page.enabled? @search_results_page.navigation_page_index_button(1)).to be false

        @object_page.click_close_button
       end
     end

>>>>>>> c424e634b81e5f22f5601800c4600fa9e8e744bc

  end
end
