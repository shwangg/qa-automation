require_relative '../../../spec_helper'

test_run = TestConfig.new Deployment::CORE_UCB
test_id = Time.now.to_i
test_data = test_run.all_authorities_test_data Deployment::CORE_UCB

describe 'Organization Authority records', order: :defined do

  include Logging
  include WebDriverManager

  before(:all) do
    test_run.set_driver launch_browser
    @admin = test_run.get_admin_user
    @login_page = test_run.get_page CoreLoginPage
    @create_new_page = test_run.get_page CoreCreateNewPage
    @exhibition_page = test_run.get_page CoreExhibitionPage
    @org_authority_page = test_run.get_page CoreOrganizationPage
    @search_page = test_run.get_page CoreSearchPage
    @search_results_page = test_run.get_page CoreSearchResultsPage

    @org_0 = test_data[0]
    @org_1 = test_data[1]
    @org_2 = test_data[2]
    @org_3 = test_data[3]
    @org_4 = test_data[4]
    @org_5 = test_data[5]
    @org_6 = test_data[6]

    # Insert the unique test ID in the test data term display names
    [@org_0, @org_1, @org_2, @org_3, @org_4, @org_5].each do |org|
      org[CoreOrgData::ORG_TERM_GRP.name].each do |term|
        term[CoreOrgData::TERM_DISPLAY_NAME.name] = "#{term[CoreOrgData::TERM_DISPLAY_NAME.name]} #{test_id}"
      end
    end

    @org_0_display_name = @org_0[CoreOrgData::ORG_TERM_GRP.name][0][CoreOrgData::TERM_DISPLAY_NAME.name]
    @org_1_display_name = @org_1[CoreOrgData::ORG_TERM_GRP.name][0][CoreOrgData::TERM_DISPLAY_NAME.name]
    @org_2_display_name_0 = @org_2[CoreOrgData::ORG_TERM_GRP.name][0][CoreOrgData::TERM_DISPLAY_NAME.name]
    @org_2_display_name_1 = @org_2[CoreOrgData::ORG_TERM_GRP.name][1][CoreOrgData::TERM_DISPLAY_NAME.name]

    @login_page.load_page
    @login_page.log_in(@admin.username, @admin.password)
  end

  after(:all) { quit_browser test_run.driver }

  context 'when part of local vocabulary' do

    it 'can be created via the Create New > Local link' do
      @search_page.click_create_new_link
      @create_new_page.click_create_new_org_local
      @org_authority_page.when_displayed(@org_authority_page.page_h2, Config.short_wait)
      expect(@org_authority_page.element(@org_authority_page.page_h2).attribute('innerText')).to eql('Organization - Local')
    end

    it 'can be saved' do
      @org_authority_page.enter_display_name(@org_0_display_name, 0)
      @org_authority_page.save_record
      expect(@org_authority_page.element(@org_authority_page.page_h2).attribute('innerText')).to eql('Organization - Local')
    end

    it 'can be added to Procedure records' do
      @org_authority_page.click_create_new_link
      @create_new_page.click_create_new_exhibition
      @exhibition_page.enter_exhibition_num({CoreExhibitionData::EXHIBITION_NUM.name => "Exhibition Zero #{test_id}"})
      @exhibition_page.select_sponsor(@org_0_display_name, 0)
      @exhibition_page.save_record
    end

    it 'are shown on the Terms Used list on the sidebar of a linked Procedure record' do
      @exhibition_page.expand_sidebar_terms_used
      @exhibition_page.click_sidebar_term @org_0_display_name
      @org_authority_page.verify_display_name(@org_0_display_name, 0)
    end
  end

  context 'when part of another (ULAN) vocabulary' do

    it 'can be created via the Create New > ULAN link' do
      @org_authority_page.click_create_new_link
      @create_new_page.click_create_new_org_ulan
      @org_authority_page.when_displayed(@org_authority_page.page_h2, Config.short_wait)
      expect(@org_authority_page.element(@org_authority_page.page_h2).attribute('innerText')).to eql('Organization - ULAN')
    end

    it 'can be saved' do
      @org_authority_page.enter_display_name(@org_1_display_name, 0)
      @org_authority_page.save_record
      expect(@org_authority_page.element(@org_authority_page.page_h2).attribute('innerText')).to eql('Organization - ULAN')
    end

    it 'can be added to Procedure records' do
      @org_authority_page.click_create_new_link
      @create_new_page.click_create_new_exhibition
      @exhibition_page.enter_exhibition_num({CoreExhibitionData::EXHIBITION_NUM.name => "Exhibition One #{test_id}"})
      @exhibition_page.select_sponsor(@org_1_display_name, 0)
      @exhibition_page.save_record
    end

    it 'are shown on the Terms Used list on the sidebar of a linked Procedure record' do
      @exhibition_page.expand_sidebar_terms_used
      @exhibition_page.click_sidebar_term @org_1_display_name
      @org_authority_page.verify_display_name(@org_1_display_name, 0)
    end
  end

  context 'when searched' do

    it 'can be filtered for all vocabulary types' do
      @org_authority_page.quick_search('Organizations', nil, "#{test_id}")
      @search_results_page.wait_for_results
      expect(@search_results_page.row_exists? @org_0_display_name).to be true
      expect(@search_results_page.row_exists? @org_1_display_name).to be true
    end

    it 'can be filtered for Local vocabulary' do
      @search_results_page.quick_search('Organizations', 'Local', "#{test_id}")
      @search_results_page.wait_for_results
      expect(@search_results_page.row_exists? @org_0_display_name).to be true
      expect(@search_results_page.row_exists? @org_1_display_name).to be false
    end

    it 'can be loaded via Local vocabulary search results' do
      @search_results_page.click_result @org_0_display_name
      @org_authority_page.wait_until(Config.short_wait) { @org_authority_page.page_title.include? @org_0_display_name }
      expect(@org_authority_page.element(@org_authority_page.page_h2).attribute('innerText')).to eql('Organization - Local')
    end

    it 'can be filtered for ULAN vocabulary' do
      @org_authority_page.quick_search('Organizations', 'ULAN', "#{test_id}")
      @search_results_page.wait_for_results
      expect(@search_results_page.row_exists? @org_0_display_name).to be false
      expect(@search_results_page.row_exists? @org_1_display_name).to be true
    end

    it 'can be loaded via ULAN vocabulary search results' do
      @search_results_page.click_result @org_1_display_name
      @org_authority_page.wait_until(Config.short_wait) { @org_authority_page.page_title.include? @org_1_display_name }
      expect(@org_authority_page.element(@org_authority_page.page_h2).attribute('innerText')).to eql('Organization - ULAN')
    end
  end

  context 'when being created' do

    it 'require a display name' do
      @org_authority_page.click_create_new_link
      @create_new_page.click_create_new_org_local
      @org_authority_page.click_save_button
      @org_authority_page.wait_for_notification 'Term display name is required. Please enter a value.'
    end

    it 'show display name as the h1 page heading' do
      @org_authority_page.enter_display_name(@org_2_display_name_0, 0)
      @org_authority_page.hit_tab
      @org_authority_page.wait_until(Config.short_wait) { @org_authority_page.element_text(@org_authority_page.page_h1) == @org_2_display_name_0 }
    end

    it 'show the display name that is in the first term row' do
      @org_authority_page.add_term_grp
      @org_authority_page.enter_display_name(@org_2_display_name_1, 1)
      @org_authority_page.move_term_grp_top 1
      @org_authority_page.save_record
      @org_authority_page.wait_until(Config.short_wait) { @org_authority_page.element_text(@org_authority_page.page_h1) == @org_2_display_name_1 }
    end
  end

  context 'when being created' do

    before(:all) do
      @org_authority_page.click_create_new_link
      @create_new_page.click_create_new_org_local
    end

    it('allow Terms to be added') { @org_authority_page.enter_terms @org_3 }
    it('allow Types to be added') { @org_authority_page.enter_types @org_3 }
    it('allow Groups to be added') { @org_authority_page.enter_groups @org_3 }
    it('allow Functions to be added') { @org_authority_page.enter_functions @org_3 }
    it('allow History Notes to be added') { @org_authority_page.enter_history_notes @org_3 }
    it('allow Foundation Date to be added') { @org_authority_page.enter_foundation_date @org_3 }
    it('allow Foundation Place to be added') { @org_authority_page.enter_foundation_place @org_3 }
    it('allow Dissolution Date to be added') { @org_authority_page.enter_dissolution_date @org_3 }
    it('allow Contact Names to be added') { @org_authority_page.enter_contact_names @org_3 }
  end

  context 'once created and saved' do

    before(:all) { @org_authority_page.save_record }

    it('display the right Terms') { expect(@org_authority_page.verify_terms @org_3).to be_empty }
    it('display the right Types') { expect(@org_authority_page.verify_types @org_3).to be_empty }
    it('display the right Groups') { expect(@org_authority_page.verify_groups @org_3).to be_empty }
    it('display the right Functions') { expect(@org_authority_page.verify_functions @org_3).to be_empty }
    it('display the right History Notes') { expect(@org_authority_page.verify_history_notes @org_3).to be_empty }
    it('display the right Foundation Date') { expect(@org_authority_page.verify_foundation_date @org_3).to be_empty }
    it('display the right Foundation Place') { expect(@org_authority_page.verify_foundation_place @org_3).to be_empty }
    it('display the right Dissolution Date') { expect(@org_authority_page.verify_dissolution_date @org_3).to be_empty }
    it('display the right Contact Names') { expect(@org_authority_page.verify_contact_names @org_3).to be_empty }

    it 'display Terms Used in the sidebar' do
      terms_used = []
      @org_3[CoreOrgData::ORG_TERM_GRP.name].each { |term| terms_used << term[CoreOrgData::TERM_SOURCE.name] }
      @org_3[CoreOrgData::CONTACT_NAMES.name].each { |name| terms_used << name[CoreOrgData::CONTACT_NAME.name] }

      @org_authority_page.expand_sidebar_terms_used
      terms_used.each { |term| @org_authority_page.when_exists(@org_authority_page.terms_used_term_link(term), 1) }
      expect(@org_authority_page.elements(@org_authority_page.terms_used_links).length).to eql(terms_used.length)
    end
  end

  context 'when being edited to add data' do

    before(:all) { @org_3 = @org_4 }

    it('allow Terms to be changed or added') { @org_authority_page.enter_terms @org_3 }
    it('allow Types to be changed or added') { @org_authority_page.enter_types @org_3 }
    it('allow Groups to be changed or added') { @org_authority_page.enter_groups @org_3 }
    it('allow Functions to be changed or added') { @org_authority_page.enter_functions @org_3 }
    it('allow History Notes to be changed or added') { @org_authority_page.enter_history_notes @org_3 }
    it('allow Foundation Date to be changed or added') { @org_authority_page.enter_foundation_date @org_3 }
    it('allow Foundation Place to be changed or added') { @org_authority_page.enter_foundation_place @org_3 }
    it('allow Dissolution Date to be changed or added') { @org_authority_page.enter_dissolution_date @org_3 }
    it('allow Contact Names to be changed or added') { @org_authority_page.enter_contact_names @org_3 }
    it('allow added data to be saved') { @org_authority_page.save_record }

    it('display the right Terms') { expect(@org_authority_page.verify_terms @org_3).to be_empty }
    it('display the right Types') { expect(@org_authority_page.verify_types @org_3).to be_empty }
    it('display the right Groups') { expect(@org_authority_page.verify_groups @org_3).to be_empty }
    it('display the right Functions') { expect(@org_authority_page.verify_functions @org_3).to be_empty }
    it('display the right History Notes') { expect(@org_authority_page.verify_history_notes @org_3).to be_empty }
    it('display the right Foundation Date') { expect(@org_authority_page.verify_foundation_date @org_3).to be_empty }
    it('display the right Foundation Place') { expect(@org_authority_page.verify_foundation_place @org_3).to be_empty }
    it('display the right Dissolution Date') { expect(@org_authority_page.verify_dissolution_date @org_3).to be_empty }
    it('display the right Contact Names') { expect(@org_authority_page.verify_contact_names @org_3).to be_empty }

    it 'display the right Terms Used in the sidebar' do
      terms_used = []
      @org_3[CoreOrgData::ORG_TERM_GRP.name].each { |term| terms_used << term[CoreOrgData::TERM_SOURCE.name] }
      @org_3[CoreOrgData::CONTACT_NAMES.name].each { |name| terms_used << name[CoreOrgData::CONTACT_NAME.name] }

      @org_authority_page.expand_sidebar_terms_used
      terms_used.each { |term| @org_authority_page.when_exists(@org_authority_page.terms_used_term_link(term), 1) }
      expect(@org_authority_page.elements(@org_authority_page.terms_used_links).length).to eql(terms_used.length)
    end
  end

  context 'when being edited to remove data' do

    before(:all) { @org_3 = @org_5 }

    it('allow Terms to be removed') { @org_authority_page.enter_terms @org_3 }
    it('allow Types to be removed') { @org_authority_page.enter_types @org_3 }
    it('allow Groups to be removed') { @org_authority_page.enter_groups @org_3 }
    it('allow Functions to be removed') { @org_authority_page.enter_functions @org_3 }
    it('allow History Notes to be removed') { @org_authority_page.enter_history_notes @org_3 }
    it('allow Foundation Date to be removed') { @org_authority_page.enter_foundation_date @org_3 }
    it('allow Foundation Place to be removed') { @org_authority_page.enter_foundation_place @org_3 }
    it('allow Dissolution Date to be removed') { @org_authority_page.enter_dissolution_date @org_3 }
    it('allow Contact Names to be removed') { @org_authority_page.enter_contact_names @org_3 }
    it('allow deleted data to be saved') { @org_authority_page.save_record }

    it('display the right Terms') { expect(@org_authority_page.verify_terms @org_3).to be_empty }
    it('display the right Types') { expect(@org_authority_page.verify_types @org_3).to be_empty }
    it('display the right Groups') { expect(@org_authority_page.verify_groups @org_3).to be_empty }
    it('display the right Functions') { expect(@org_authority_page.verify_functions @org_3).to be_empty }
    it('display the right History Notes') { expect(@org_authority_page.verify_history_notes @org_3).to be_empty }
    it('display the right Foundation Date') { expect(@org_authority_page.verify_foundation_date @org_3).to be_empty }
    it('display the right Foundation Place') { expect(@org_authority_page.verify_foundation_place @org_3).to be_empty }
    it('display the right Dissolution Date') { expect(@org_authority_page.verify_dissolution_date @org_3).to be_empty }
    it('display the right Contact Names') { expect(@org_authority_page.verify_contact_names @org_3).to be_empty }

    it 'display the right Terms Used in the sidebar' do
      @org_authority_page.expand_sidebar_terms_used
      expect(@org_authority_page.elements(@org_authority_page.terms_used_links)).to be_empty
    end
  end

  context 'when being edited' do

    it 'cannot have all display names removed' do
      @org_authority_page.enter_display_name('', 0)
      @org_authority_page.hit_tab
      @org_authority_page.wait_until(1) { !@org_authority_page.enabled?(@org_authority_page.save_button) }
      @org_authority_page.wait_for_notification 'Term display name is required. Please enter a value.'
    end
  end

  context 'when being deleted' do

    context 'and the authority is not in use by other records' do

      before(:all) do
        @org_authority_page.revert_record
        @org_6_display_name = "Org 6 #{test_id}"
        @org_authority_page.click_create_new_link
        @create_new_page.click_create_new_org_local
        @org_authority_page.enter_display_name(@org_6_display_name, 0)
        @org_authority_page.save_record
      end

      it 'requires confirmation' do
        @org_authority_page.click_delete_button
        @org_authority_page.when_displayed(@org_authority_page.confirm_delete_msg_span, 1)
      end

      it 'can be canceled by clicking the Cancel button' do
        @org_authority_page.cancel_deletion
        @org_authority_page.when_not_exists(@org_authority_page.confirm_delete_msg_span, 1)
      end

      it 'can be canceled by clicking the Close button' do
        @org_authority_page.click_delete_button
        @org_authority_page.when_displayed(@org_authority_page.confirm_delete_msg_span, 1)
        @org_authority_page.click_close_button
        @org_authority_page.when_not_exists(@org_authority_page.confirm_delete_msg_span, 1)
      end

      it('can be confirmed') { @org_authority_page.delete_record }

      it 'prevents the term being returned in search results' do
        @search_results_page.click_search_link
        @search_page.full_text_search @org_6_display_name
        @search_results_page.when_displayed(@search_results_page.no_results_msg, Config.short_wait)
      end
    end

    context 'and the authority is in use by other records' do

      before(:all) do
        @search_results_page.click_create_new_link
        @create_new_page.click_create_new_exhibition
        @exhibition_page.enter_exhibition_num({CoreExhibitionData::EXHIBITION_NUM.name => "Exhibition Two #{test_id}"})
        @exhibition_page.select_sponsor(@org_1_display_name, 0)
        @exhibition_page.save_record

        @search_results_page.click_create_new_link
        @create_new_page.click_create_new_exhibition
        @exhibition_page.enter_exhibition_num({CoreExhibitionData::EXHIBITION_NUM.name => "Exhibition Three #{test_id}"})
        @exhibition_page.select_sponsor(@org_1_display_name, 0)
        @exhibition_page.save_record
      end

      it 'cannot be done if it is in use by other records' do
        @exhibition_page.expand_sidebar_terms_used
        @exhibition_page.click_sidebar_term @org_1_display_name
        @org_authority_page.click_delete_button
        @org_authority_page.when_displayed(@org_authority_page.confirm_delete_msg_span, 1)
        expect(@org_authority_page.element_text(@org_authority_page.confirm_delete_msg_span)).to eql("#{@org_1_display_name} cannot be deleted because it is used by other records.")
      end
    end
  end

  context 'when no changes have been made' do

    before(:all) do
      @org_authority_page.cancel_deletion if @org_authority_page.exists?(@org_authority_page.confirm_delete_cancel_button)
      @org_authority_page.quick_search('Organizations', nil, "#{test_id}")
      @search_results_page.click_result @org_1_display_name
    end

    it 'show disabled revert buttons' do
      @org_authority_page.when_displayed(@org_authority_page.revert_button, Config.short_wait)
      expect(@org_authority_page.enabled? @org_authority_page.revert_button).to be false
    end
  end

  context 'when unsaved changes have been made' do

    before(:all) { @org_authority_page.enter_foundation_date({CoreOrgData::FOUNDING_DATE.name => '01/01/2000'}) }

    it 'offer revert buttons that reverse the changes' do
      @org_authority_page.revert_record
      expect(@org_authority_page.verify_foundation_date({CoreOrgData::FOUNDING_DATE.name => ''})).to be_empty
    end
  end

  context 'when saved changes have been made' do

    before(:all) do
      @org_authority_page.enter_dissolution_date({CoreOrgData::DISSOLUTION_DATE.name => '12/31/2000'})
      @org_authority_page.save_record
    end

    it 'show disabled revert buttons' do
      @org_authority_page.when_displayed(@org_authority_page.revert_button, Config.short_wait)
      expect(@org_authority_page.enabled? @org_authority_page.revert_button).to be false
    end
  end

  context 'with unsaved changes' do

    it 'offer a Don\'t Leave button' do
      @org_authority_page.enter_foundation_date({CoreOrgData::FOUNDING_DATE.name => '01/01/2000'})
      @org_authority_page.click_search_link
      @org_authority_page.do_not_leave_record
      expect(@org_authority_page.verify_foundation_date({CoreOrgData::FOUNDING_DATE.name => '01/01/2000'})).to be_empty
    end

    it 'offer a Close button' do
      @org_authority_page.click_search_link
      @org_authority_page.click_close_button
      expect(@org_authority_page.verify_foundation_date({CoreOrgData::FOUNDING_DATE.name => '01/01/2000'})).to be_empty
    end

    it 'offer a Revert and Continue button' do
      @org_authority_page.click_search_link
      @org_authority_page.revert_and_continue
      @search_page.when_exists(@search_page.search_button_two, Config.short_wait)
      @search_page.quick_search('Organizations', nil, "#{test_id}")
      @search_results_page.click_result @org_1_display_name
      expect(@org_authority_page.verify_foundation_date({CoreOrgData::FOUNDING_DATE.name => ''})).to be_empty
    end

    it 'offer a Save and Continue button' do
      @org_authority_page.enter_foundation_date({CoreOrgData::FOUNDING_DATE.name => '01/01/2000'})
      @org_authority_page.click_search_link
      @org_authority_page.save_and_continue
      @search_page.when_exists(@search_page.search_button_two, Config.short_wait)
      @search_page.quick_search('Organizations', nil, "#{test_id}")
      @search_results_page.click_result @org_1_display_name
      expect(@org_authority_page.verify_foundation_date({CoreOrgData::FOUNDING_DATE.name => '01/01/2000'})).to be_empty
    end
  end
end
