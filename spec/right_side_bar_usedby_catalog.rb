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

#      empty_menu = {:xpath => //header[contains(., 'Related Objects')]/following-sibling::div//div[@class = "cspace-ui-SearchResultEmpty--common"]}

      @login_page.load_page
      @login_page.log_in("students@cspace.berkeley.edu", "cspacestudents")
        #@admin.username, @admin.password)

      @test_1_object = {
        CoreObjectData::OBJECT_NUM.name => Time.now.to_i
      }
      @test_7_object = {
        CoreObjectData::OBJECT_NUM.name => Time.now.to_i * 3
      }

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

    end

    after(:all) { quit_browser test_run.driver }

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


  end
end
