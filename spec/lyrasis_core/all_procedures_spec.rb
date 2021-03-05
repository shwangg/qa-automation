require_relative '../../spec_helper'

test_id = Time.now.to_i

describe 'Use of Collection records' do

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
    @use_of_collections_page = UseOfCollectionsPage.new @test
    @authority_page = AuthorityPage.new @test

    test_data = @test.all_procedures_test_data
    @uoc_0 = test_data[0]
    @uoc_1 = test_data[1]
    @uoc_2 = test_data[2]
    @uoc_3 = test_data[3]
    @uoc_4 = test_data[4]
    @uoc_5 = test_data[5]
    @uoc_6 = test_data[6]

    # Insert the unique test ID in the test data reference numbers
    [@uoc_1, @uoc_2, @uoc_3, @uoc_4, @uoc_5, @uoc_6].each do |uoc|
      uoc[CoreUseOfCollectionsData::REFERENCE_NBR.name] = "#{uoc[CoreUseOfCollectionsData::REFERENCE_NBR.name]} #{test_id}"
    end

    @terms_used = []

    @login_page.load_page
    @login_page.log_in(@admin.username, @admin.password)
  end

  after(:all) { quit_browser @test.driver }

  context 'when created' do

    it 'require a reference number' do
      @search_page.click_create_new_link
      @create_new_page.click_create_new_use_of_collections
      @use_of_collections_page.click_save_button
      @use_of_collections_page.wait_for_notification 'Reference number is required. Please enter a value.'
    end

    it 'allow the user to choose a generated reference number of a selected pattern' do
      ref_num = @use_of_collections_page.select_id_generator_option(@use_of_collections_page.reference_nbr_input, @use_of_collections_page.reference_nbr_options)
      @uoc_0.merge!({ CoreUseOfCollectionsData::REFERENCE_NBR.name => ref_num })
      expect(ref_num).not_to be_empty
    end

    it 'show the user the "last generated value" for a reference number' do
      # Pause to allow the last-generated-value to be updated
      @use_of_collections_page.hit_tab
      @use_of_collections_page.wait_for_element_and_click @use_of_collections_page.reference_nbr_input
      @use_of_collections_page.wait_until(Config.short_wait) { @use_of_collections_page.elements(@use_of_collections_page.reference_nbr_options).any? &:displayed? }
      sleep 2
      expect(@use_of_collections_page.elements(@use_of_collections_page.reference_nbr_options).first.text).to include(@uoc_0[CoreUseOfCollectionsData::REFERENCE_NBR.name])
    end

    it 'allow the user to choose an incremented reference number of a selected pattern' do
      @use_of_collections_page.hit_tab
      prev_ref_num = @uoc_0[CoreUseOfCollectionsData::REFERENCE_NBR.name].split(//).last.to_i
      new_ref_num = @use_of_collections_page.select_id_generator_option(@use_of_collections_page.reference_nbr_input, @use_of_collections_page.reference_nbr_options)
      last_digit = new_ref_num.split(//).last.to_i
      (prev_ref_num == 9) ? (expect(last_digit).to be_zero) : (expect(last_digit).to eql(prev_ref_num + 1))

    end
  end

  context 'when being created' do

    before(:all) { @use_of_collections_page.revert_record }

    it('allow a Reference Number to be added') { @use_of_collections_page.enter_reference_nbr @uoc_1 }
    it('allow Methods to be added') { @use_of_collections_page.select_methods @uoc_1 }
    it('allow a Title to be added') { @use_of_collections_page.enter_title @uoc_1 }
    it('allow an Authorization to be added') { @use_of_collections_page.enter_authorizations @uoc_1 }
    it('allow Use Dates to be added') { @use_of_collections_page.enter_use_dates @uoc_1 }
    it('allow an End Date to be added') { @use_of_collections_page.enter_end_date @uoc_1 }
    it('allow Users to be added') { @use_of_collections_page.enter_users @uoc_1 }
    it('allow Locations to be added') { @use_of_collections_page.enter_locations @uoc_1 }
    it('allow Staff to be added') { @use_of_collections_page.enter_staff @uoc_1 }
    it('allow Occasions to be added') { @use_of_collections_page.enter_occasions @uoc_1 }
    it('allow a Note to be added') { @use_of_collections_page.enter_note @uoc_1 }
    it('allow Provisos to be added') { @use_of_collections_page.enter_provisos @uoc_1 }
    it('allow a Result to be added') { @use_of_collections_page.enter_result @uoc_1 }
  end

  context 'once created and saved' do

    before(:all) { @use_of_collections_page.save_record }

    it('show the right Reference Number') { @use_of_collections_page.verify_reference_nbr @uoc_1 }
    it('show the right Methods') { @use_of_collections_page.verify_methods @uoc_1 }
    it('show the right Title') { @use_of_collections_page.verify_title @uoc_1 }
    it('show the right Authorizations') { @use_of_collections_page.verify_authorizations @uoc_1 }
    it('show the right Use Dates') { @use_of_collections_page.verify_use_dates @uoc_1 }
    it('show the right End Date') { @use_of_collections_page.verify_end_date @uoc_1 }
    it('show the right Users') { @use_of_collections_page.verify_users @uoc_1 }
    it('show the right Locations') { @use_of_collections_page.verify_locations @uoc_1 }
    it('show the right Staff') { @use_of_collections_page.verify_staff @uoc_1 }
    it('show the right Occasions') { @use_of_collections_page.verify_occasions @uoc_1 }
    it('show the right Note') { @use_of_collections_page.verify_note @uoc_1 }
    it('show the right Provisos') { @use_of_collections_page.verify_provisos @uoc_1 }
    it('show the right Result') { @use_of_collections_page.verify_result @uoc_1 }

    it 'shows the Reference Number and the Title in the procedure header' do
      expected_heading = "#{@uoc_1[CoreUseOfCollectionsData::REFERENCE_NBR.name]} – #{@uoc_1[CoreUseOfCollectionsData::TITLE.name]}"
      expect(@use_of_collections_page.element_text @use_of_collections_page.page_h1).to eql(expected_heading)
    end

    it 'show the right Terms used in the sidebar' do
      @uoc_1[CoreUseOfCollectionsData::USER_GRP.name].each do |user|
        @terms_used << user[CoreUseOfCollectionsData::USER.name]
        @terms_used << user[CoreUseOfCollectionsData::USER_INSTITUTION.name]
      end
      @uoc_1[CoreUseOfCollectionsData::AUTHORIZATION_GRP.name].each { |auth| @terms_used << auth[CoreUseOfCollectionsData::AUTHORIZED_BY.name] }
      @uoc_1[CoreUseOfCollectionsData::STAFF_GRP.name].each { |staff| @terms_used << staff[CoreUseOfCollectionsData::STAFF_NAME.name] }
      @uoc_1[CoreUseOfCollectionsData::OCCASION_LIST.name].each { |occ| @terms_used << occ[CoreUseOfCollectionsData::OCCASION.name] }
      @uoc_1[CoreUseOfCollectionsData::LOCATION_LIST.name].each { |loc| @terms_used << loc[CoreUseOfCollectionsData::LOCATION.name] }
      @terms_used.compact!

      @use_of_collections_page.show_twenty_terms
      errors = []
      @terms_used.each do |term|
        @use_of_collections_page.attempt_action(errors, "Term #{term} not found") do
          @use_of_collections_page.when_exists(@use_of_collections_page.terms_used_term_link(term), 1)
        end
      end
      @use_of_collections_page.wait_until(1, "Expected errors #{errors} to be empty") { errors.empty? }
    end

    it 'provide links to Terms used records' do
      uoc_url = @use_of_collections_page.url
      @terms_used.each do |term|
        @use_of_collections_page.get(uoc_url) unless @use_of_collections_page.url == uoc_url
        @use_of_collections_page.click_sidebar_term term
        @authority_page.wait_until(Config.short_wait) { @authority_page.page_title.include? term }
        @authority_page.expand_sidebar_used_by
        @authority_page.click_sidebar_used_by @uoc_1[CoreUseOfCollectionsData::REFERENCE_NBR.name]
        @use_of_collections_page.wait_until(Config.short_wait) { @use_of_collections_page.page_title.include? @uoc_1[CoreUseOfCollectionsData::REFERENCE_NBR.name] }
      end
    end
  end

  context 'when edited' do

    it('allow the Reference Number to be edited') { @use_of_collections_page.enter_reference_nbr @uoc_2 }
    it('allow Methods to be removed') { @use_of_collections_page.select_methods @uoc_2 }
    it('allow a Title to be removed') { @use_of_collections_page.enter_title @uoc_2 }
    it('allow an Authorization to be removed') { @use_of_collections_page.enter_authorizations @uoc_2 }
    it('allow Use Dates to be removed') { @use_of_collections_page.enter_use_dates @uoc_2 }
    it('allow an End Date to be removed') { @use_of_collections_page.enter_end_date @uoc_2 }
    it('allow Users to be removed') { @use_of_collections_page.enter_users @uoc_2 }
    it('allow Locations to be removed') { @use_of_collections_page.enter_locations @uoc_2 }
    it('allow Staff to be removed') { @use_of_collections_page.enter_staff @uoc_2 }
    it('allow Occasions to be removed') { @use_of_collections_page.enter_occasions @uoc_2 }
    it('allow a Note to be removed') { @use_of_collections_page.enter_note @uoc_2 }
    it('allow Provisos to be removed') { @use_of_collections_page.enter_provisos @uoc_2 }
    it('allow a Result to be removed') { @use_of_collections_page.enter_result @uoc_2 }
    it('allow deleted data to be saved') { @use_of_collections_page.save_record }

    it('show the right Reference Number') { @use_of_collections_page.verify_reference_nbr @uoc_2 }
    it('show the right Methods') { @use_of_collections_page.verify_methods @uoc_2 }
    it('show the right Title') { @use_of_collections_page.verify_title @uoc_2 }
    it('show the right Authorizations') { @use_of_collections_page.verify_authorizations @uoc_2 }
    it('show the right Use Dates') { @use_of_collections_page.verify_use_dates @uoc_2 }
    it('show the right End Date') { @use_of_collections_page.verify_end_date @uoc_2 }
    it('show the right Users') { @use_of_collections_page.verify_users @uoc_2 }
    it('show the right Locations') { @use_of_collections_page.verify_locations @uoc_2 }
    it('show the right Staff') { @use_of_collections_page.verify_staff @uoc_2 }
    it('show the right Occasions') { @use_of_collections_page.verify_occasions @uoc_2 }
    it('show the right Note') { @use_of_collections_page.verify_note @uoc_2 }
    it('show the right Provisos') { @use_of_collections_page.verify_provisos @uoc_2 }
    it('show the right Result') { @use_of_collections_page.verify_result @uoc_2 }

    it 'shows the Reference Number and the Title in the procedure header' do
      expected_heading = "#{@uoc_2[CoreUseOfCollectionsData::REFERENCE_NBR.name]}"
      expect(@use_of_collections_page.element_text @use_of_collections_page.page_h1).to eql(expected_heading)
    end

    it 'show the right Terms used in the sidebar' do
      @use_of_collections_page.expand_sidebar_terms_used
      expect(@use_of_collections_page.elements @use_of_collections_page.terms_used_links).to be_empty
    end

    it 'do not allow the reference number to be removed' do
      @use_of_collections_page.enter_reference_nbr({ CoreUseOfCollectionsData::REFERENCE_NBR.name => '' })
      @use_of_collections_page.hit_tab
      @use_of_collections_page.wait_for_notification 'Reference number is required. Please enter a value.'
      expect(@use_of_collections_page.enabled? @use_of_collections_page.save_button).to be false
    end
  end

  context 'when being deleted' do

    context 'and the procedure is not in use by other records' do

      before(:all) do
        @use_of_collections_page.revert_record
        @use_of_collections_page.click_create_new_link
        @create_new_page.click_create_new_use_of_collections
        @use_of_collections_page.enter_reference_nbr @uoc_3
        @use_of_collections_page.save_record
      end

      it 'requires confirmation' do
        @use_of_collections_page.click_delete_button
        @use_of_collections_page.when_displayed(@use_of_collections_page.confirm_delete_msg_span, 1)
      end

      it 'can be canceled by clicking the Cancel button' do
        @use_of_collections_page.cancel_deletion
        @use_of_collections_page.when_not_exists(@use_of_collections_page.confirm_delete_msg_span, 1)
      end

      it 'can be canceled by clicking the Close button' do
        @use_of_collections_page.click_delete_button
        @use_of_collections_page.when_displayed(@use_of_collections_page.confirm_delete_msg_span, 1)
        @use_of_collections_page.click_close_button
        @use_of_collections_page.when_not_exists(@use_of_collections_page.confirm_delete_msg_span, 1)
      end

      it('can be deleted') { @use_of_collections_page.delete_record }

      it 'prevents the procedure being returned in search results' do
        @search_results_page.click_search_link
        @search_page.quick_search('Use of Collections', nil, @uoc_3[CoreUseOfCollectionsData::REFERENCE_NBR.name])
        @search_results_page.when_displayed(@search_results_page.no_results_msg, Config.short_wait)
      end
    end

    context 'and the procedure is associated with other procedure records' do

      before(:all) do
        @search_results_page.click_create_new_link
        @create_new_page.click_create_new_use_of_collections
        @use_of_collections_page.enter_reference_nbr @uoc_4
        @use_of_collections_page.save_record

        @use_of_collections_page.click_create_new_link
        @create_new_page.click_create_new_use_of_collections
        @use_of_collections_page.enter_reference_nbr @uoc_5
        @use_of_collections_page.save_record

        @use_of_collections_page.click_add_related_procedure
        @search_page.full_text_search @uoc_4[CoreUseOfCollectionsData::REFERENCE_NBR.name]
        @search_results_page.wait_for_results
        @search_results_page.relate_records [@uoc_4[CoreUseOfCollectionsData::REFERENCE_NBR.name]]
        @use_of_collections_page.save_record
      end

      it('can be deleted successfully') { @use_of_collections_page.delete_record }
    end
  end

  context 'when no changes have been made' do

    before(:all) do
      @search_page.click_create_new_link
      @create_new_page.click_create_new_use_of_collections
      @use_of_collections_page.enter_reference_nbr @uoc_6
      @use_of_collections_page.save_record
    end

    it('show disabled revert buttons') { expect(@use_of_collections_page.enabled? @use_of_collections_page.revert_button).to be false }
  end

  context 'when unsaved changes have been made' do

    before(:all) do
      @use_of_collections_page.enter_title({ CoreUseOfCollectionsData::TITLE.name => 'Unsaved change' })
      @use_of_collections_page.hit_tab
    end

    it 'offer revert buttons that reverse the changes' do
      @use_of_collections_page.revert_record
      @use_of_collections_page.verify_title({ CoreUseOfCollectionsData::TITLE.name => '' })
    end
  end

  context 'when saved changes have been made' do

    before(:all) do
      @use_of_collections_page.enter_title({ CoreUseOfCollectionsData::TITLE.name => 'Saved change' })
      @use_of_collections_page.save_record
      @uoc_6.merge!({ CoreUseOfCollectionsData::TITLE.name => 'Saved change' })
    end

    it 'show disabled revert buttons' do
      @use_of_collections_page.when_displayed(@use_of_collections_page.revert_button, Config.short_wait)
      expect(@use_of_collections_page.enabled? @use_of_collections_page.revert_button).to be false
    end
  end

  context 'with unsaved changes' do

    it 'offer a Don\'t Leave button' do
      @use_of_collections_page.enter_title({ CoreUseOfCollectionsData::TITLE.name => 'Unsaved change' })
      @use_of_collections_page.click_search_link
      @use_of_collections_page.do_not_leave_record
      @use_of_collections_page.verify_title({ CoreUseOfCollectionsData::TITLE.name => 'Unsaved change' })
    end

    it 'offer a Close button' do
      @use_of_collections_page.click_search_link
      @use_of_collections_page.click_close_button
      @use_of_collections_page.verify_title({ CoreUseOfCollectionsData::TITLE.name => 'Unsaved change' })
    end

    it 'offer a Revert and Continue button' do
      @use_of_collections_page.click_search_link
      @use_of_collections_page.revert_and_continue
      @search_page.when_exists(@search_page.search_button_two, Config.short_wait)
      @search_page.quick_search('Use of Collections', nil, @uoc_6[CoreUseOfCollectionsData::REFERENCE_NBR.name])
      @search_results_page.click_result @uoc_6[CoreUseOfCollectionsData::REFERENCE_NBR.name]
      @use_of_collections_page.verify_title @uoc_6
    end

    it 'offer a Save and Continue button' do
      @use_of_collections_page.enter_title({ CoreUseOfCollectionsData::TITLE.name => 'Saved title' })
      @use_of_collections_page.click_search_link
      @use_of_collections_page.save_and_continue
      @uoc_6.merge!({ CoreUseOfCollectionsData::TITLE.name => 'Saved title' })
      @search_page.when_exists(@search_page.search_button_two, Config.short_wait)
      @search_page.quick_search('Use of Collections', nil, @uoc_6[CoreUseOfCollectionsData::REFERENCE_NBR.name])
      @search_results_page.click_result @uoc_6[CoreUseOfCollectionsData::TITLE.name]
      @use_of_collections_page.verify_title @uoc_6
    end
  end

  context 'when the user clicks the fold button for the Use of Collections Info form' do

    before { @use_of_collections_page.hide_uoc_info_form }

    it('hides the form') { @use_of_collections_page.when_not_exists(@use_of_collections_page.reference_nbr_input, 1) }
  end

  context 'when the user clicks the unfold button for the Use of Collections Info form' do

    before { @use_of_collections_page.show_uoc_info_form }

    it('unhides the form') { @use_of_collections_page.when_displayed(@use_of_collections_page.reference_nbr_input, 1) }
  end
end
