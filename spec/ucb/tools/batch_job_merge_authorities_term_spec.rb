require_relative '../../../spec_helper'

deploy = Deployment::PAHMA

describe "The #{deploy.name} merge authorities batch job" do

  include Logging
  include WebDriverManager

  before(:all) do
    @test = TestConfig.new deploy
    @test.set_driver launch_browser
    @test_data = @test.inventory_movement_test_data deploy
    @test_id = Time.now.to_i.to_s
    @admin = @test.get_admin_user

    @login_page = @test.get_page CoreLoginPage
    @search_results_page = @test.get_page CoreSearchResultsPage
    @create_new_page = @test.get_page CoreCreateNewPage
    @org_page = @test.get_page CoreOrganizationPage
    @citation_page = @test.get_page CoreCitationPage
    @concept_page = @test.get_page CoreConceptPage

    @object_page = @test.get_page CoreObjectPage
    @inventory_movement_page = @test.get_page CoreInventoryMovementPage
    @search_page = @test.get_page CoreSearchPage
    @tools_page = @test.get_page CoreToolsPage
    @batch_jobs_page = @test.get_page CoreInvocablesPage

    @login_page.load_page
    @login_page.log_in(@admin.username, @admin.password)
    @search_page.click_tools_link
    @tools_page.click_batch_link
  end

  after(:all) { quit_browser @test.driver }

  it('is available on the Tools page') { expect(@search_results_page.row_exists? 'Merge Authority Items').to be true }

  describe 'configuration' do

    before(:all) do
      @batch_jobs_page.click_invocable 'Merge Authority Items'
    end

    CoreAuthorityType::TYPES.each do |type|
      it("includes '#{type.name}'") do
        logger.info "Checking for #{@batch_jobs_page.invocable_batch_doctype_locator(type.name)}"
        @batch_jobs_page.when_exists(@batch_jobs_page.invocable_batch_doctype_locator(type.name), Config.short_wait)
      end
    end
  end

  describe 'merging two authorities' do

    before(:all) do
      @test_id = Time.now.to_i
      [(@merge2_1 = "MergeTest2Record_1 #{@test_id}"),
       (@merge2_2 = "MergeTest2Record_2 #{@test_id}")].each do |org|
        @batch_jobs_page.click_create_new_link
        @create_new_page.click_create_new_org_local
        @org_page.enter_display_name(org, 0)
        @org_page.save_record
        @org_page.verify_display_name(org, 0)
      end

      @org_page.click_tools_link
      @tools_page.click_batch_link
      @batch_jobs_page.click_invocable 'Merge Authority Items'
    end

    it 'allows the user to search for an authority to merge' do
      @batch_jobs_page.click_run_button
      @batch_jobs_page.choose_run_on_option 'single record'
      @batch_jobs_page.click_select_record_button
      @search_page.click_modal_clear_button
      @search_page.select_record_type_option 'Organizations'
      @search_page.enter_keyword @test_id
      @search_page.click_search_button
      @search_results_page.wait_for_results
      @search_results_page.click_search_result_cbx @merge2_2
    end

    it('allows the user to select the authority to merge') { @search_results_page.click_use_selection_button }

    it 'allows the user to merge the authority into another authority' do
      @batch_jobs_page.enter_target_record @merge2_1
      @batch_jobs_page.click_invoke_button
      @batch_jobs_page.wait_for_notification 'Completed Merge Authority Items: 2 records affected.'
      @batch_jobs_page.wait_for_notification "Updated the target record, #{@merge2_1}."
      @batch_jobs_page.wait_for_notification "No records referenced the source record, #{@merge2_2}."
      @batch_jobs_page.wait_for_notification "Deleted the source record, #{@merge2_2}."
    end

    it 'allows the user to search for the authority into which the other authority was merged' do
      @batch_jobs_page.quick_search('Organizations', 'All', @merge2_1)
      @search_results_page.click_result @merge2_1
    end

    it 'shows the merged authority as a repeating term on the authority into which it was merged' do
      @org_page.wait_until(Config.short_wait) do
        @org_page.element_value(@org_page.display_name_input 0) == @merge2_1
        @org_page.element_value(@org_page.display_name_input 1) == @merge2_2
      end
    end
  end

  describe 'merging a list of records' do

    before(:all) do
      @test_id = Time.now.to_i
      [(@merge3_1 = "MergeTest3Record_1 #{@test_id}"),
       (@merge3_2 = "MergeTest3Record_2 #{@test_id}"),
       (@merge3_3 = "MergeTest3Record_3 #{@test_id}"),
       (@merge3_4 = "MergeTest3Record_4 #{@test_id}")].each do |org|
        sleep 1
        @org_page.click_create_new_link
        @create_new_page.click_create_new_org_local
        @org_page.enter_display_name(org, 0)
        @org_page.save_record
        @org_page.verify_display_name(org, 0)
      end

      @org_page.click_tools_link
      @tools_page.click_batch_link
      @batch_jobs_page.click_invocable 'Merge Authority Items'
    end

    it 'allows the user to search for authorities to merge' do
      @batch_jobs_page.click_run_button
      @batch_jobs_page.choose_run_on_option 'record list'
      @batch_jobs_page.click_select_record_button
      @search_page.click_modal_clear_button
      @search_page.select_record_type_option 'Organizations'
      @search_page.enter_display_names [@test_id]
      @search_page.click_search_button
      @search_results_page.wait_for_results
      @search_results_page.click_search_result_cbx @merge3_2
      @search_results_page.click_search_result_cbx @merge3_3
      @search_results_page.click_search_result_cbx @merge3_4
    end

    it('allows the user to select the authorities to merge') { @search_results_page.click_use_selection_button }

    it 'allows the user to merge the authority into another authority' do
      @batch_jobs_page.enter_target_record @merge3_1
      @batch_jobs_page.click_invoke_button
      msg = 'Completed Merge Authority Items: 4 records affected.'
      msg3_1 = "Updated the target record, #{@merge3_1}."
      msg3_2_1 = "No records referenced the source record, #{@merge3_2}."
      msg3_2_2 = "Deleted the source record, #{@merge3_2}."
      msg3_3_1 = "No records referenced the source record, #{@merge3_3}."
      msg3_3_2 = "Deleted the source record, #{@merge3_3}."
      msg3_4_1 = "No records referenced the source record, #{@merge3_4}."
      msg3_4_2 = "Deleted the source record, #{@merge3_4}."
      @batch_jobs_page.wait_for_notification msg
      @batch_jobs_page.wait_for_notification msg3_1
      @batch_jobs_page.wait_for_notification msg3_2_1
      @batch_jobs_page.wait_for_notification msg3_2_2
      @batch_jobs_page.wait_for_notification msg3_3_1
      @batch_jobs_page.wait_for_notification msg3_3_2
      @batch_jobs_page.wait_for_notification msg3_4_1
      @batch_jobs_page.wait_for_notification msg3_4_2
    end

    it 'allows the user to search for the authority into which the other authorities were merged' do
      @batch_jobs_page.quick_search('Organizations', 'All', @merge3_1)
      @search_results_page.wait_for_results
      @search_results_page.click_result @merge3_1
    end

    it 'shows the merged authority as a repeating term on the authority into which it was merged' do
      @org_page.wait_until(Config.short_wait) do
        @org_page.element_value(@org_page.display_name_input 0) == @merge3_1
        @org_page.element_value(@org_page.display_name_input 1) == @merge3_2
        @org_page.element_value(@org_page.display_name_input 2) == @merge3_3
        @org_page.element_value(@org_page.display_name_input 3) == @merge3_4
      end
    end
  end

  describe 'merging invalid records' do

    before(:all) do
      @test_id = Time.now.to_i
      @merge4_1 = "CitationMerge_1 #{@test_id}"
      @batch_jobs_page.click_create_new_link
      @create_new_page.click_create_new_authority_citation_local
      @citation_page.enter_display_name(@merge4_1, 0)
      @citation_page.save_record
      @citation_page.verify_display_name(@merge4_1, 0)

      @merge4_2 = "ConceptMerge_1 #{@test_id}"
      @citation_page.click_create_new_link
      @create_new_page.click_create_new_authority_concept_activity
      @concept_page.enter_term_display_name(@merge4_2, 0)
      @concept_page.save_record
      @concept_page.verify_display_name(@merge4_2, 0)

      @concept_page.click_tools_link
      @tools_page.click_batch_link
      @batch_jobs_page.click_invocable 'Merge Authority Items'
    end

    it 'displays an error' do
      @batch_jobs_page.click_run_button
      @batch_jobs_page.choose_run_on_option 'single record'
      @batch_jobs_page.click_select_record_button
      @search_page.click_modal_clear_button
      @search_page.select_record_type_option 'Citations'
      @search_page.enter_keyword @test_id
      @search_page.click_search_button
      @search_results_page.wait_for_results
      @search_results_page.click_search_result_cbx @merge4_1
      @search_results_page.click_use_selection_button
      @batch_jobs_page.enter_target_record @merge4_2
      @batch_jobs_page.click_invoke_button
      @batch_jobs_page.wait_for_notification 'Error running org.collectionspace.services.batch.nuxeo.MergeAuthorityItemsBatchJob'
    end
  end

  describe 'merging authorities with the same display name and no conflicts' do

    before(:all) do
      @test_id = Time.now.to_i.to_s
      @merge5_1_name = "OrgMerge5_1 #{@test_id}"
      @merge5_1 = {
          CoreOrgData::ORG_TERM_GRP.name => [
              {
                  CoreOrgData::TERM_DISPLAY_NAME.name => @merge5_1_name,
                  CoreOrgData::TERM_STATUS.name => "accepted",
                  CoreOrgData::TERM_TYPE.name => "descriptor",
                  CoreOrgData::TERM_FLAG.name => "official name",
                  CoreOrgData::TERM_LANGUAGE.name => "French"
              }
          ]
      }
      @batch_jobs_page.click_create_new_link
      @create_new_page.click_create_new_org_local
      @org_page.enter_terms @merge5_1
      @org_page.save_record
      @org_page.verify_display_name(@merge5_1_name, 0)

      @merge5_2_name = "OrgMerge5_2 #{@test_id}"
      @merge5_2 = {
          CoreOrgData::ORG_TERM_GRP.name => [
              {
                  CoreOrgData::TERM_DISPLAY_NAME.name => @merge5_2_name
              },
              {
                  CoreOrgData::TERM_DISPLAY_NAME.name => @merge5_1_name,
                  CoreOrgData::TERM_SOURCE.name => "Term Source 0"
              }
          ],
          CoreOrgData::FUNCTIONS.name => [
              {
                  CoreOrgData::FUNCTION.name => "Function 0"
              }
          ],
          CoreOrgData::HISTORY_NOTES.name => [
              {
                  CoreOrgData::HISTORY_NOTE.name => "History Note 0"
              }
          ],
          CoreOrgData::FOUNDING_DATE.name => "01/01/1999",
          CoreOrgData::CONTACT_NAMES.name => [
              {
                  CoreOrgData::CONTACT_NAME.name => "Contact Name 0"
              }
          ]
      }
      @org_page.click_create_new_link
      @create_new_page.click_create_new_org_local
      @org_page.enter_terms @merge5_2
      @org_page.enter_functions @merge5_2
      @org_page.enter_history_notes @merge5_2
      @org_page.enter_foundation_date @merge5_2
      @org_page.enter_contact_names @merge5_2
      @org_page.save_record
      @org_page.verify_display_name(@merge5_2_name, 0)

      @concept_page.click_tools_link
      @tools_page.click_batch_link
      @batch_jobs_page.click_invocable 'Merge Authority Items'
    end

    it 'merges the records' do
      @batch_jobs_page.click_run_button
      @batch_jobs_page.choose_run_on_option 'single record'
      @batch_jobs_page.click_select_record_button
      @search_page.click_modal_clear_button
      @search_page.select_record_type_option 'Organizations'
      @search_page.enter_keyword @test_id
      @search_page.click_search_button
      @search_results_page.wait_for_results
      @search_results_page.click_search_result_cbx @merge5_1_name
      @search_results_page.click_use_selection_button
      @batch_jobs_page.enter_target_record @merge5_2_name
      @batch_jobs_page.click_invoke_button
      @merge5_2[CoreOrgData::ORG_TERM_GRP.name][1].merge! @merge5_1[CoreOrgData::ORG_TERM_GRP.name][0]
      @batch_jobs_page.wait_for_notification 'Completed Merge Authority Items: 2 records affected.'
      @batch_jobs_page.wait_for_notification "Updated the target record, #{@merge5_2_name}."
      @batch_jobs_page.wait_for_notification "No records referenced the source record, #{@merge5_1_name}."
      @batch_jobs_page.wait_for_notification "Deleted the source record, #{@merge5_1_name}."
    end

    it 'allows the user to search for the authority into which the other authorities were merged' do
      @batch_jobs_page.quick_search('Organizations', 'All', @merge5_2_name)
      @search_results_page.wait_for_results
      @search_results_page.click_result @merge5_2_name
    end

    it('merges the Terms') { expect(@org_page.verify_terms @merge5_2).to be_empty }
    it('merges the Types') { expect(@org_page.verify_types @merge5_2).to be_empty }
    it('merges the Groups') { expect(@org_page.verify_groups @merge5_2).to be_empty }
    it('merges the Functions') { expect(@org_page.verify_functions @merge5_2).to be_empty }
    it('merges the History Notes') { expect(@org_page.verify_history_notes @merge5_2).to be_empty }
    it('merges the Foundation Date') { expect(@org_page.verify_foundation_date @merge5_2).to be_empty }
    it('merges the Foundation Place') { expect(@org_page.verify_foundation_place @merge5_2).to be_empty }
    it('merges the Dissolution Date') { expect(@org_page.verify_dissolution_date @merge5_2).to be_empty }
    it('merges the Contact Names') { expect(@org_page.verify_contact_names @merge5_2).to be_empty }
  end

  describe 'merging authorities with the same display name and with conflicting values' do

    before(:all) do
      @test_id = Time.now.to_i.to_s
      @merge6_1_name = "OrgMerge6_1 #{@test_id}"
      @merge6_1 = {
          CoreOrgData::ORG_TERM_GRP.name => [
              {
                  CoreOrgData::TERM_DISPLAY_NAME.name => @merge6_1_name,
                  CoreOrgData::TERM_STATUS.name => "accepted",
                  CoreOrgData::TERM_TYPE.name => "descriptor",
                  CoreOrgData::TERM_FLAG.name => "official name",
                  CoreOrgData::TERM_LANGUAGE.name => "French"
              }
          ]
      }
      @batch_jobs_page.click_create_new_link
      @create_new_page.click_create_new_org_local
      @org_page.enter_terms @merge6_1
      @org_page.save_record
      @org_page.verify_display_name(@merge6_1_name, 0)

      @merge6_2_name = "OrgMerge6_2 #{@test_id}"
      @merge6_2 = {
          CoreOrgData::ORG_TERM_GRP.name => [
              {
                  CoreOrgData::TERM_DISPLAY_NAME.name => @merge6_2_name
              },
              {
                  CoreOrgData::TERM_DISPLAY_NAME.name => @merge6_1_name,
                  CoreOrgData::TERM_STATUS.name => "under review",
                  CoreOrgData::TERM_LANGUAGE.name => "German",
                  CoreOrgData::TERM_SOURCE.name => "Term Source 0"
              }
          ],
          CoreOrgData::HISTORY_NOTES.name => [
              {
                  CoreOrgData::HISTORY_NOTE.name => "History Note 0"
              }
          ]
      }
      @org_page.click_create_new_link
      @create_new_page.click_create_new_org_local
      @org_page.enter_terms @merge6_2
      @org_page.enter_history_notes @merge6_2
      @org_page.save_record
      @org_page.verify_display_name(@merge6_2_name, 0)

      @concept_page.click_tools_link
      @tools_page.click_batch_link
      @batch_jobs_page.click_invocable 'Merge Authority Items'
    end

    it 'displays an error' do
      @batch_jobs_page.click_run_button
      @batch_jobs_page.choose_run_on_option 'single record'
      @batch_jobs_page.click_select_record_button
      @search_page.click_modal_clear_button
      @search_page.select_record_type_option 'Organizations'
      @search_page.enter_keyword @test_id
      @search_page.click_search_button
      @search_results_page.wait_for_results
      @search_results_page.click_search_result_cbx @merge6_1_name
      @search_results_page.click_use_selection_button
      @batch_jobs_page.enter_target_record @merge6_2_name
      @batch_jobs_page.click_invoke_button
      @batch_jobs_page.wait_for_notification 'Error running org.collectionspace.services.batch.nuxeo.MergeAuthorityItemsBatchJob'
    end
  end
end
