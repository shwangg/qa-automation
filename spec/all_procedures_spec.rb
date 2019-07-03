require_relative '../spec_helper'

test_run = TestConfig.new

if test_run.deployment == Deployment::CORE

  describe 'Use of Collection records' do

    include Logging
    include WebDriverManager

    test_id = Time.now.to_i
    test_data = test_run.all_procedures_test_data

    before(:all) do
      test_run.set_driver launch_browser
      @admin = test_run.get_admin_user
      @login_page = test_run.get_page LoginPage
      @create_new_page = test_run.get_page CreateNewPage
      @search_page = test_run.get_page SearchPage
      @search_results_page = test_run.get_page SearchResultsPage
      @use_of_collections_page = test_run.get_page UseOfCollectionsPage
      @authority_page = AuthorityPage.new test_run.driver

      @uoc_0 = test_data[0]
      @uoc_1 = test_data[1]
      @uoc_2 = test_data[2]
      @uoc_3 = test_data[3]
      @uoc_4 = test_data[4]
      @uoc_5 = test_data[5]
      @uoc_6 = test_data[6]

      # Insert the unique test ID in the test data reference numbers
      [@uoc_1, @uoc_2, @uoc_3, @uoc_4, @uoc_5, @uoc_6].each do |uoc|
        uoc[UseOfCollectionsData::REFERENCE_NBR.name] = "#{uoc[UseOfCollectionsData::REFERENCE_NBR.name]} #{test_id}"
      end

      @terms_used = []

      @login_page.load_page
      @login_page.log_in(@admin.username, @admin.password)
    end

    after(:all) { quit_browser test_run.driver }

    context 'when created' do

      it 'require a reference number' do
        @search_page.click_create_new_link
        @create_new_page.click_create_new_use_of_collections
        @use_of_collections_page.click_save_button
        @use_of_collections_page.wait_for_notification 'Reference number is required. Please enter a value.'
      end

      it 'allow the user to choose a generated reference number of a selected pattern' do
        ref_num = @use_of_collections_page.select_id_generator_option(@use_of_collections_page.reference_nbr_input, @use_of_collections_page.reference_nbr_options)
        @uoc_0.merge!({UseOfCollectionsData::REFERENCE_NBR.name => ref_num})
        expect(ref_num).not_to be_empty
      end

      it 'show the user the "last generated value" for a reference number' do
        # Pause to allow the last-generated-value to be updated
        @use_of_collections_page.hit_tab
        @use_of_collections_page.wait_for_element_and_click @use_of_collections_page.reference_nbr_input
        @use_of_collections_page.wait_until(Config.short_wait) { @use_of_collections_page.elements(@use_of_collections_page.reference_nbr_options).any? &:displayed? }
        sleep 2
        expect(@use_of_collections_page.elements(@use_of_collections_page.reference_nbr_options).first.text).to include(@uoc_0[UseOfCollectionsData::REFERENCE_NBR.name])
      end

      it 'allow the user to choose an incremented reference number of a selected pattern' do
        @use_of_collections_page.hit_tab
        new_ref_num = @use_of_collections_page.select_id_generator_option(@use_of_collections_page.reference_nbr_input, @use_of_collections_page.reference_nbr_options)
        expect(new_ref_num.split(//).last.to_i).to eql(@uoc_0[UseOfCollectionsData::REFERENCE_NBR.name].split(//).last.to_i + 1)
      end
    end

    context 'when being created' do

      before(:all) { @use_of_collections_page.revert_record }

      it('allow a Reference Number to be added') { @use_of_collections_page.enter_reference_nbr @uoc_1 }
      it('allow Methods to be added') { @use_of_collections_page.select_methods @uoc_1 }
      it('allow a Title to be added') { @use_of_collections_page.enter_title @uoc_1 }
      it('allow an Authorized By to be added') { @use_of_collections_page.enter_authorized_by @uoc_1 }
      it('allow an Authorization Date to be added') { @use_of_collections_page.enter_authorization_date @uoc_1 }
      it('allow an Authorization Note to be added') { @use_of_collections_page.enter_authorization_note @uoc_1 }
      it('allow a Start Date to be added') { @use_of_collections_page.enter_start_single_date @uoc_1 }
      it('allow an End Date to be added') { @use_of_collections_page.enter_end_date @uoc_1 }
      it('allow Users to be added') { @use_of_collections_page.enter_users @uoc_1 }
      it('allow a Location to be added') { @use_of_collections_page.enter_location @uoc_1 }
      it('allow a Note to be added') { @use_of_collections_page.enter_note @uoc_1 }
      it('allow Provisos to be added') { @use_of_collections_page.enter_provisos @uoc_1 }
      it('allow a Result to be added') { @use_of_collections_page.enter_result @uoc_1 }
    end

    context 'once created and saved' do

      before(:all) { @use_of_collections_page.save_record }

      it('show the right Reference Number') { @use_of_collections_page.verify_reference_nbr @uoc_1 }
      it('show the right Methods') { @use_of_collections_page.verify_methods @uoc_1 }
      it('show the right Title') { @use_of_collections_page.verify_title @uoc_1 }
      it('show the right Authorized By') { @use_of_collections_page.verify_authorized_by @uoc_1 }
      it('show the right Authorization Date') { @use_of_collections_page.verify_authorization_date @uoc_1 }
      it('show the right Authorization Note') { @use_of_collections_page.verify_authorization_note @uoc_1 }
      it('show the right Start Date') { @use_of_collections_page.verify_start_single_date @uoc_1 }
      it('show the right End Date') { @use_of_collections_page.verify_end_date @uoc_1 }
      it('show the right Users') { @use_of_collections_page.verify_users @uoc_1 }
      it('show the right Location') { @use_of_collections_page.verify_location @uoc_1 }
      it('show the right Note') { @use_of_collections_page.verify_note @uoc_1 }
      it('show the right Provisos') { @use_of_collections_page.verify_provisos @uoc_1 }
      it('show the right Result') { @use_of_collections_page.verify_result @uoc_1 }

      it 'shows the Reference Number and the Title in the procedure header' do
        expected_heading = "#{@uoc_1[UseOfCollectionsData::REFERENCE_NBR.name]} – #{@uoc_1[UseOfCollectionsData::TITLE.name]}"
        expect(@use_of_collections_page.element_text @use_of_collections_page.page_h1).to eql(expected_heading)
      end

      it 'show the right Terms used in the sidebar' do
        @terms_used << @uoc_1[UseOfCollectionsData::AUTHORIZED_BY.name]
        @terms_used << @uoc_1[UseOfCollectionsData::LOCATION.name]
        @uoc_1[UseOfCollectionsData::USER_GRP.name].each { |name| @terms_used << name[UseOfCollectionsData::USER.name] }

        @use_of_collections_page.expand_sidebar_terms_used
        @terms_used.each { |term| @use_of_collections_page.when_exists(@use_of_collections_page.terms_used_term_link_locator(term), 1) }
        expect(@use_of_collections_page.elements(@use_of_collections_page.terms_used_term_links_locator).length).to eql(@terms_used.length)
      end

      it 'provide links to Terms used records' do
        uoc_url = @use_of_collections_page.url
        @terms_used.each do |term|
          @use_of_collections_page.get(uoc_url) unless @use_of_collections_page.url == uoc_url
          @use_of_collections_page.click_sidebar_term term
          @authority_page.wait_until(Config.short_wait) { @authority_page.page_title.include? term }
          @authority_page.expand_sidebar_used_by
          @authority_page.click_sidebar_used_by @uoc_1[UseOfCollectionsData::REFERENCE_NBR.name]
          @use_of_collections_page.wait_until(Config.short_wait) { @use_of_collections_page.page_title.include? @uoc_1[UseOfCollectionsData::REFERENCE_NBR.name] }
        end
      end
    end

    context 'when edited' do

      it('allow the Reference Number to be edited') { @use_of_collections_page.enter_reference_nbr @uoc_2 }
      it('allow Methods to be removed') { @use_of_collections_page.select_methods @uoc_2 }
      it('allow a Title to be removed') { @use_of_collections_page.enter_title @uoc_2 }
      it('allow an Authorized By to be removed') { @use_of_collections_page.enter_authorized_by @uoc_2 }
      it('allow an Authorization Date to be removed') { @use_of_collections_page.enter_authorization_date @uoc_2 }
      it('allow an Authorization Note to be removed') { @use_of_collections_page.enter_authorization_note @uoc_2 }
      it('allow a Start Date to be removed') { @use_of_collections_page.enter_start_single_date @uoc_2 }
      it('allow an End Date to be removed') { @use_of_collections_page.enter_end_date @uoc_2 }
      it('allow Users to be removed') { @use_of_collections_page.enter_users @uoc_2 }
      it('allow a Location to be removed') { @use_of_collections_page.enter_location @uoc_2 }
      it('allow a Note to be removed') { @use_of_collections_page.enter_note @uoc_2 }
      it('allow Provisos to be removed') { @use_of_collections_page.enter_provisos @uoc_2 }
      it('allow a Result to be removed') { @use_of_collections_page.enter_result @uoc_2 }
      it('allow deleted data to be saved') { @use_of_collections_page.save_record }

      it('show the right Reference Number') { @use_of_collections_page.verify_reference_nbr @uoc_2 }
      it('show the right Methods') { @use_of_collections_page.verify_methods @uoc_2 }
      it('show the right Title') { @use_of_collections_page.verify_title @uoc_2 }
      it('show the right Authorized By') { @use_of_collections_page.verify_authorized_by @uoc_2 }
      it('show the right Authorization Date') { @use_of_collections_page.verify_authorization_date @uoc_2 }
      it('show the right Authorization Note') { @use_of_collections_page.verify_authorization_note @uoc_2 }
      it('show the right Start Date') { @use_of_collections_page.verify_start_single_date @uoc_2 }
      it('show the right End Date') { @use_of_collections_page.verify_end_date @uoc_2 }
      it('show the right Users') { @use_of_collections_page.verify_users @uoc_2 }
      it('show the right Location') { @use_of_collections_page.verify_location @uoc_2 }
      it('show the right Note') { @use_of_collections_page.verify_note @uoc_2 }
      it('show the right Provisos') { @use_of_collections_page.verify_provisos @uoc_2 }
      it('show the right Result') { @use_of_collections_page.verify_result @uoc_2 }

      it 'shows the Reference Number and the Title in the procedure header' do
        expected_heading = "#{@uoc_2[UseOfCollectionsData::REFERENCE_NBR.name]}"
        expect(@use_of_collections_page.element_text @use_of_collections_page.page_h1).to eql(expected_heading)
      end

      it 'show the right Terms used in the sidebar' do
        @use_of_collections_page.expand_sidebar_terms_used
        expect(@use_of_collections_page.elements @use_of_collections_page.terms_used_term_links_locator).to be_empty
      end

      it 'do not allow the reference number to be removed' do
        @use_of_collections_page.enter_reference_nbr({UseOfCollectionsData::REFERENCE_NBR.name => ''})
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
          @search_page.quick_search('Use of Collections', nil, @uoc_3[UseOfCollectionsData::REFERENCE_NBR.name])
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
          @search_page.full_text_search @uoc_4[UseOfCollectionsData::REFERENCE_NBR.name]
          @search_results_page.wait_for_results
          @search_results_page.relate_records [@uoc_4[UseOfCollectionsData::REFERENCE_NBR.name]]
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
        @use_of_collections_page.enter_title({UseOfCollectionsData::TITLE.name => 'Unsaved change'})
        @use_of_collections_page.hit_tab
      end

      it 'offer revert buttons that reverse the changes' do
        @use_of_collections_page.revert_record
        @use_of_collections_page.verify_title({UseOfCollectionsData::TITLE.name => ''})
      end
    end

    context 'when saved changes have been made' do

      before(:all) do
        @use_of_collections_page.enter_title({UseOfCollectionsData::TITLE.name => 'Saved change'})
        @use_of_collections_page.save_record
        @uoc_6.merge!({UseOfCollectionsData::TITLE.name => 'Saved change'})
      end

      it 'show disabled revert buttons' do
        @use_of_collections_page.when_displayed(@use_of_collections_page.revert_button, Config.short_wait)
        expect(@use_of_collections_page.enabled? @use_of_collections_page.revert_button).to be false
      end
    end

    context 'with unsaved changes' do

      it 'offer a Don\'t Leave button' do
        @use_of_collections_page.enter_title({UseOfCollectionsData::TITLE.name => 'Unsaved change'})
        @use_of_collections_page.click_search_link
        @use_of_collections_page.do_not_leave_record
        @use_of_collections_page.verify_title({UseOfCollectionsData::TITLE.name => 'Unsaved change'})
      end

      it 'offer a Close button' do
        @use_of_collections_page.click_search_link
        @use_of_collections_page.click_close_button
        @use_of_collections_page.verify_title({UseOfCollectionsData::TITLE.name => 'Unsaved change'})
      end

      it 'offer a Revert and Continue button' do
        @use_of_collections_page.click_search_link
        @use_of_collections_page.revert_and_continue
        @search_page.when_exists(@search_page.search_button_two, Config.short_wait)
        @search_page.quick_search('Use of Collections', nil, @uoc_6[UseOfCollectionsData::REFERENCE_NBR.name])
        @search_results_page.click_result @uoc_6[UseOfCollectionsData::REFERENCE_NBR.name]
        @use_of_collections_page.verify_title @uoc_6
      end

      it 'offer a Save and Continue button' do
        @use_of_collections_page.enter_title({UseOfCollectionsData::TITLE.name => 'Saved title'})
        @use_of_collections_page.click_search_link
        @use_of_collections_page.save_and_continue
        @uoc_6.merge!({UseOfCollectionsData::TITLE.name => 'Saved title'})
        @search_page.when_exists(@search_page.search_button_two, Config.short_wait)
        @search_page.quick_search('Use of Collections', nil, @uoc_6[UseOfCollectionsData::REFERENCE_NBR.name])
        @search_results_page.click_result @uoc_6[UseOfCollectionsData::TITLE.name]
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
end
