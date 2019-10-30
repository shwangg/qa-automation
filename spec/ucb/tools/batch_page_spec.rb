require_relative '../../../spec_helper'

describe 'Batch' do

  include Logging
  include WebDriverManager

  test_run = TestConfig.new
  test_id = Time.now.to_i

  before(:all) do
    test_run.set_driver launch_browser
    @admin = test_run.get_admin_user
    @login_page = test_run.get_page CoreLoginPage
    @create_new_page = test_run.get_page CoreCreateNewPage
    @batch_page = test_run.get_page CoreInvocablesPage
    @search_page = test_run.get_page CoreSearchPage
    @tools_page = test_run.get_page CoreToolsPage
    @search_results_page = test_run.get_page CoreSearchResultsPage

    @test_0 = {
        CoreInvocablesData::INVOCABLE_NAME.name => 'Merge Authority Items',
        CoreInvocablesData::INVOCABLE_DESC.name =>  '',
        CoreInvocablesData::INVOCABLE_RUNS_ON_PANEL.label => 'Runs on',
    }

    @test_1 = {
      CoreInvocablesData::INVOCABLE_NAME.name => 'Non-Existing Batchjob',
  }

    @login_page.load_page
    @login_page.log_in(@admin.username, @admin.password)
    @search_page.click_tools_link
    @tools_page.click_batch_link

  end

  after(:all) { quit_browser test_run.driver}

  describe 'interacting with the data updates page tab' do

    context 'checking ability to click buttons and fill fields' do

      it 'should not be able to change the name of a data update' do
        @batch_page.click_invocable @test_0[CoreInvocablesData::INVOCABLE_NAME.name]
        sleep 1
        expect(@batch_page.element_value @batch_page.invocable_name_locator).to eql(@test_0[CoreInvocablesData::INVOCABLE_NAME.name])
        expect(@batch_page.enabled? @batch_page.invocable_name_locator).to be false
        expect(@batch_page.enabled? @batch_page.revert_button).to be false
        expect(@batch_page.enabled? @batch_page.run_button).to be true
      end

      it 'should not be able to change the description of a data update' do
        @batch_page.click_invocable @test_0[CoreInvocablesData::INVOCABLE_NAME.name]
        sleep 1
        expect(@batch_page.element_value @batch_page.invocable_description_locator).to eql(@test_0[CoreInvocablesData::INVOCABLE_DESC.name ])
        expect(@batch_page.enabled? @batch_page.invocable_description_locator).to be false
        expect(@batch_page.enabled? @batch_page.revert_button).to be false
        expect(@batch_page.enabled? @batch_page.run_button).to be true
      end

      it 'should not be able to alter the class name associated with the data update' do
        @batch_page.click_invocable @test_0[CoreInvocablesData::INVOCABLE_NAME.name]
        @batch_page.uncollapse_panel_if_collapsed CoreInvocablesData::INVOCABLE_RUNS_ON_PANEL.label

        expect(@batch_page.enabled? @batch_page.invocable_classname_locator).to be false
        expect(@batch_page.enabled? @batch_page.revert_button).to be false
        expect(@batch_page.enabled? @batch_page.run_button).to be true
      end

      it 'should not be able to alter the data type contexts' do
        @batch_page.click_invocable @test_0[CoreInvocablesData::INVOCABLE_NAME.name]
        @batch_page.uncollapse_panel_if_collapsed CoreInvocablesData::INVOCABLE_RUNS_ON_PANEL.label
        expect(@batch_page.enabled? @batch_page.invocable_no_ctx_locator).to be false
        expect(@batch_page.enabled? @batch_page.invocable_single_ctx_locator).to be false
        expect(@batch_page.enabled? @batch_page.invocable_group_ctx_locator).to be false
        expect(@batch_page.enabled? @batch_page.invocable_list_ctx_locator).to be false
        expect(@batch_page.enabled? @batch_page.revert_button).to be false
        expect(@batch_page.enabled? @batch_page.run_button).to be true
      end

      it 'should not be able to alter the record types' do
        @batch_page.click_invocable @test_0[CoreInvocablesData::INVOCABLE_NAME.name]
        @batch_page.uncollapse_panel_if_collapsed CoreInvocablesData::INVOCABLE_RUNS_ON_PANEL.label
        expect(@batch_page.enabled? @batch_page.invocable_doctypes_locator).to be false
        expect(@batch_page.enabled? @batch_page.revert_button).to be false
        expect(@batch_page.enabled? @batch_page.run_button).to be true
      end

      it 'should not be able to alter whether the data update creates a new focus' do
        @batch_page.click_invocable @test_0[CoreInvocablesData::INVOCABLE_NAME.name]
        @batch_page.uncollapse_panel_if_collapsed CoreInvocablesData::INVOCABLE_RUNS_ON_PANEL.label
        expect(@batch_page.enabled? @batch_page.invocable_batch_new_focus_locator).to be false
        expect(@batch_page.enabled? @batch_page.revert_button).to be false
        expect(@batch_page.enabled? @batch_page.run_button).to be true
      end
    end

    context 'Data updates UI interactions' do

      it 'should be able to filter based on a search' do
        @tools_page.fill_filter_bar(@test_0[CoreInvocablesData::INVOCABLE_NAME.name])
        expect(@search_results_page.row_exists? @test_0[CoreInvocablesData::INVOCABLE_NAME.name]).to be true
        expect(@search_results_page.row_exists? @test_1[CoreInvocablesData::INVOCABLE_NAME.name]).to be false
      end

      it 'should show all results when the clear button is clicked' do
        @tools_page.fill_filter_bar(@test_0[CoreInvocablesData::INVOCABLE_NAME.name])
        expect(@search_results_page.row_exists? @test_0[CoreInvocablesData::INVOCABLE_NAME.name]).to be true
        expect(@search_results_page.row_exists? @test_1[CoreInvocablesData::INVOCABLE_NAME.name]).to be false

        @tools_page.click_clear_button
        expect(@search_results_page.row_exists? @test_0[CoreInvocablesData::INVOCABLE_NAME.name]).to be true
        expect(@search_results_page.row_exists? @test_1[CoreInvocablesData::INVOCABLE_NAME.name]).to be false
      end

      it 'should be able to bring up a modal and dismiss it with the escape key' do
          @batch_page.click_invocable @test_0[CoreInvocablesData::INVOCABLE_NAME.name]

          @tools_page.click_run_button
          expect(@batch_page.exists? @batch_page.invocable_modal).to be true # for the modal to exist
          @batch_page.hit_escape
          expect(@batch_page.exists? @batch_page.invocable_modal).to be false
      end

      it 'should be able to bring up a modal and dismiss it with the cancel button' do 
        @batch_page.click_invocable @test_0[CoreInvocablesData::INVOCABLE_NAME.name]

        @tools_page.click_run_button
        expect(@batch_page.exists? @batch_page.invocable_modal).to be true # for the modal to exist
        @tools_page.click_cancel_modal_button
        expect(@batch_page.exists? @batch_page.invocable_modal).to be false
      end 

      it 'should be able to bring up a modal and dismiss it with the close button' do 
        @batch_page.click_invocable @test_0[CoreInvocablesData::INVOCABLE_NAME.name]

        @tools_page.click_run_button
        expect(@batch_page.exists? @batch_page.invocable_modal).to be true # for the modal to exist
        @batch_page.click_close_button
        expect(@batch_page.exists? @batch_page.invocable_modal).to be false
      end
      
      it 'should be able to collapse and uncollapse the Data Updates and Runs on panels' do
        @batch_page.click_invocable @test_0[CoreInvocablesData::INVOCABLE_NAME.name]

        #runs on
        # uncollapse it
        @batch_page.uncollapse_panel_if_collapsed CoreInvocablesData::INVOCABLE_RUNS_ON_PANEL.label
        expect(@batch_page.is_collapsed CoreInvocablesData::INVOCABLE_RUNS_ON_PANEL.label).to be false

        # collapse it
        @batch_page.toggle_panel CoreInvocablesData::INVOCABLE_RUNS_ON_PANEL.label
        expect(@batch_page.is_collapsed CoreInvocablesData::INVOCABLE_RUNS_ON_PANEL.label).to be true


        # uncollapse it
        @batch_page.toggle_panel CoreInvocablesData::INVOCABLE_RUNS_ON_PANEL.label
        expect(@batch_page.is_collapsed CoreInvocablesData::INVOCABLE_RUNS_ON_PANEL.label).to be false


        #Data updates
        @batch_page.uncollapse_panel_if_collapsed CoreInvocablesData::INVOCABLE_BATCH_LIST_PANEL.label
        expect(@batch_page.is_collapsed CoreInvocablesData::INVOCABLE_BATCH_LIST_PANEL.label).to be false

        # collapse it
        @batch_page.toggle_panel CoreInvocablesData::INVOCABLE_BATCH_LIST_PANEL.label
        expect(@batch_page.is_collapsed CoreInvocablesData::INVOCABLE_BATCH_LIST_PANEL.label).to be true


        # recollapse it
        @batch_page.toggle_panel CoreInvocablesData::INVOCABLE_BATCH_LIST_PANEL.label
        expect(@batch_page.is_collapsed CoreInvocablesData::INVOCABLE_BATCH_LIST_PANEL.label).to be false

      end
    end
  end
end

