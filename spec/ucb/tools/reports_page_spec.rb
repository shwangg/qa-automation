require_relative '../../../spec_helper'

describe 'Reports' do

  include Logging
  include WebDriverManager

  before(:all) do
    test_id = Time.now.to_i
    @test = TestConfig.new Deployment::CORE_UCB
    @test.set_driver launch_browser
    @admin = @test.get_admin_user
    @reports_user = @test.get_test_user test_id

    @login_page = LoginPage.new @test
    @create_new_page = CreateNewPage.new @test
    @reports_page = InvocablesPage.new @test
    @search_page = SearchPage.new @test
    @tools_page = ToolsPage.new @test
    @admin_page = AdminPage.new @test
    @search_results_page = SearchResultsPage.new @test

    @test_0 = {
        CoreInvocablesData::INVOCABLE_NAME.name => 'Use of Collections Approval Status Report',
        CoreInvocablesData::INVOCABLE_DESC.name =>  'Lists Use of Collections requests with a value in the \'Authorization\' field group, filtered by authorized by, authorization status, and/or date requested range. Displays the record number, title, requested date, completed date, authorization date, authorizer and authorization status. Available output formats: PDF, CSV, MS Word.',
    }

    @test_1 = {
        CoreInvocablesData::INVOCABLE_NAME.name => 'Use of Collections by Requester and/or Object Report',
        CoreInvocablesData::INVOCABLE_RUNS_ON_PANEL.label => 'Runs on',
        CoreInvocablesData::INVOCABLE_REPORT_LIST_PANEL.label => 'Reports'
    }

    @no_perms = {
      CoreUCBRecordTypes::USERS.name => "D",
      CoreUCBRecordTypes::ROLES.name => "W"
    }
    @no_perms_role = UserRole.new("NO_REPORT_PERMISSIONS_#{test_id}",
                                  'No Permissions to run or invoke reports',
                                  @test.deployment,
                                  @no_perms)

    @full_perms = {
      CoreUCBRecordTypes::USERS.name => "D",
      CoreUCBRecordTypes::ROLES.name => "W",
      CoreUCBRecordTypes::REPORT_INVOC.name => "D",
      CoreUCBRecordTypes::REPORTS.name => "D"
    }
    @full_perms_role = UserRole.new("CAN_EDIT_CAN_RUN_#{test_id}",
                                    'A role with CRUDL permissions',
                                    @test.deployment,
                                    @full_perms)

    @invoke_perms = {
      CoreUCBRecordTypes::USERS.name => "D",
      CoreUCBRecordTypes::ROLES.name => "W",
      CoreUCBRecordTypes::REPORT_INVOC.name => "D",
      CoreUCBRecordTypes::REPORTS.name => "R"
    }
    @invoke_perms_role = UserRole.new("CANT_EDIT_CAN_RUN_UPDATES_#{test_id}",
                                      'A role with only Invocation permissions',
                                      @test.deployment,
                                      @invoke_perms)

    @edit_perms = {
      CoreUCBRecordTypes::REPORTS.name => "D",
      CoreUCBRecordTypes::USERS.name => "D",
      CoreUCBRecordTypes::ROLES.name => "W"
    }
    @edit_perms_role = UserRole.new("CAN_EDIT_CANT_RUN_#{test_id}",
                                    'A role with only Edit permissions',
                                    @test.deployment,
                                    @edit_perms)

    # Initial Setup of Roles
    @login_page.load_page
    @login_page.log_in(@admin.username, @admin.password)
    @search_page.click_admin_link
    @admin_page.click_roles_link
    [@no_perms_role, @full_perms_role, @invoke_perms_role, @edit_perms_role].each { |role| @admin_page.create_user_role role }

    # Account Setup
    @reports_user.roles = [@no_perms_role]
    @admin_page.click_users_link
    @admin_page.create_new_user @reports_user
  end

  after(:all) do
    @search_page.log_out
    @login_page.log_in(@admin.username, @admin.password)
    @search_page.click_admin_link
    @admin_page.delete_user @reports_user if @admin_page.user_exists? @reports_user
    [@no_perms_role, @full_perms_role, @invoke_perms_role, @edit_perms_role].each do |role|
      @admin_page.delete_user_role role if @admin_page.role_exists? role
    end
  rescue => e
    logger.error "#{e.message}\n#{e.backtrace.join("\n")}"
  ensure
    quit_browser @test.driver
  end

  describe 'user with editor and invoker permissions interacting with the reports page tab' do

    before(:all) do
      @search_page.click_admin_link
      @admin_page.click_users_link

      @admin_page.change_user_role(@reports_user, @no_perms_role.name, @full_perms_role.name)
      # currently the UI doesn't allow us to check which role is selected...
      # expect(@admin_page.role_locator(@FULL_PERMISSIONS)).to be true
      @search_page.log_out
      @login_page.log_in(@reports_user.username, @reports_user.password)
      @search_page.click_tools_link
      @tools_page.click_reports_link
    end

    context 'report UI interactions' do

      it 'should be able to filter based on a search' do
        @search_results_page.fill_search_filter_bar(@test_0[CoreInvocablesData::INVOCABLE_NAME.name])
        expect(@search_results_page.row_exists? @test_0[CoreInvocablesData::INVOCABLE_NAME.name]).to be true
        expect(@search_results_page.row_exists? @test_1[CoreInvocablesData::INVOCABLE_NAME.name]).to be false
      end

      it 'should be able to bring up a modal and dismiss it using the escape key' do
        @reports_page.click_invocable @test_0[CoreInvocablesData::INVOCABLE_NAME.name]

        @tools_page.click_run_button
        expect(@reports_page.exists? @reports_page.invocable_modal).to be true # for the modal to exist
        @reports_page.hit_escape
        expect(@reports_page.exists? @reports_page.invocable_modal).to be false
      end

      it 'should be able to bring up a modal and dismiss it using the cancel button' do
        @reports_page.click_invocable @test_0[CoreInvocablesData::INVOCABLE_NAME.name]

        @tools_page.click_run_button
        expect(@reports_page.exists? @reports_page.invocable_modal).to be true # for the modal to exist
        @tools_page.click_cancel_modal_button
        expect(@reports_page.exists? @reports_page.invocable_modal).to be false
      end

      it 'should be able to bring up a modal and dismiss it using the close button' do
        @reports_page.click_invocable @test_0[CoreInvocablesData::INVOCABLE_NAME.name]

        @tools_page.click_run_button
        expect(@reports_page.exists? @reports_page.invocable_modal).to be true # for the modal to exist
        @reports_page.click_close_button
        expect(@reports_page.exists? @reports_page.invocable_modal).to be false
      end
    end

    context 'checking ability to click buttons and fill fields' do

      it 'should be able to change the name of a report' do
        @reports_page.click_invocable @test_0[CoreInvocablesData::INVOCABLE_NAME.name]
        sleep 1
        expect(@reports_page.element_value @reports_page.invocable_name_locator).to eql(@test_0[CoreInvocablesData::INVOCABLE_NAME.name])
        expect(@reports_page.enabled? @reports_page.invocable_name_locator).to be true
        expect(@reports_page.enabled? @reports_page.revert_button).to be false
        expect(@reports_page.enabled? @reports_page.run_button).to be true

        @reports_page.edit_invocable_name_and_save("This is a new test name")
        sleep 1
        expect(@reports_page.element_value @reports_page.invocable_name_locator).not_to eq(@test_0[CoreInvocablesData::INVOCABLE_NAME.name])

        @reports_page.edit_invocable_name_and_save(@test_0[CoreInvocablesData::INVOCABLE_NAME.name])
        sleep 1
        expect(@reports_page.element_value @reports_page.invocable_name_locator).to eq(@test_0[CoreInvocablesData::INVOCABLE_NAME.name])

      end

      it 'should be able to change the description of a report' do
        @reports_page.click_invocable @test_0[CoreInvocablesData::INVOCABLE_NAME.name]
        sleep 1
        expect(@reports_page.element_value(@reports_page.invocable_description_locator).gsub(/\s+/, ' ').strip).to eql(@test_0[CoreInvocablesData::INVOCABLE_DESC.name])
        expect(@reports_page.enabled? @reports_page.invocable_description_locator).to be true
        expect(@reports_page.enabled? @reports_page.revert_button).to be false
        expect(@reports_page.enabled? @reports_page.run_button).to be true

        @reports_page.edit_description_and_save("This is a new test description")
        expect(@reports_page.element_value @reports_page.invocable_description_locator).not_to eq(@test_0[CoreInvocablesData::INVOCABLE_DESC.name])

        @reports_page.edit_description_and_save(@test_0[CoreInvocablesData::INVOCABLE_DESC.name])
        expect(@reports_page.element_value @reports_page.invocable_description_locator).to eq(@test_0[CoreInvocablesData::INVOCABLE_DESC.name])
      end

      it 'should not be able to alter the Jasper file associated with the report' do
        @reports_page.click_invocable @test_0[CoreInvocablesData::INVOCABLE_NAME.name]
        @reports_page.uncollapse_panel_if_collapsed CoreInvocablesData::INVOCABLE_RUNS_ON_PANEL.label

        expect(@reports_page.enabled? @reports_page.invocable_report_filename_locator).to be false
        expect(@reports_page.enabled? @reports_page.revert_button).to be false
        expect(@reports_page.enabled? @reports_page.run_button).to be true
      end

      it 'should not be able to alter the report contexts' do
        @reports_page.click_invocable @test_0[CoreInvocablesData::INVOCABLE_NAME.name]
        @reports_page.uncollapse_panel_if_collapsed CoreInvocablesData::INVOCABLE_RUNS_ON_PANEL.label
        expect(@reports_page.enabled? @reports_page.invocable_no_ctx_locator).to be false
        expect(@reports_page.enabled? @reports_page.invocable_single_ctx_locator).to be false
        expect(@reports_page.enabled? @reports_page.invocable_group_ctx_locator).to be false
        expect(@reports_page.enabled? @reports_page.invocable_list_ctx_locator).to be false
        expect(@reports_page.enabled? @reports_page.revert_button).to be false
        expect(@reports_page.enabled? @reports_page.run_button).to be true
      end

      it 'should not be able to alter the record types or default MIME type' do
        @reports_page.click_invocable @test_0[CoreInvocablesData::INVOCABLE_NAME.name]
        @reports_page.uncollapse_panel_if_collapsed CoreInvocablesData::INVOCABLE_RUNS_ON_PANEL.label
        expect(@reports_page.enabled? @reports_page.invocable_report_doctypes_locator).to be false
        expect(@reports_page.enabled? @reports_page.invocable_mimetype_locator).to be false
        expect(@reports_page.enabled? @reports_page.revert_button).to be false
        expect(@reports_page.enabled? @reports_page.run_button).to be true
      end
    end
  end

  describe 'user with only edit permissions interacting with the UI' do

    before(:all) do
      @search_page.click_admin_link
      @admin_page.click_users_link

      @admin_page.change_user_role(@reports_user, @full_perms_role.name, @edit_perms_role.name)
      # currently the UI doesn't allow us to check which role is selected...
      # expect(@admin_page.role_locator(@FULL_PERMISSIONS)).to be true
      @search_page.log_out
      @login_page.log_in(@reports_user.username, @reports_user.password)
      @search_page.click_tools_link
      @tools_page.click_reports_link
    end

    it 'should be able to change the name of a report' do
      @search_results_page.fill_search_filter_bar(@test_0[CoreInvocablesData::INVOCABLE_NAME.name])
      @reports_page.click_invocable @test_0[CoreInvocablesData::INVOCABLE_NAME.name]
      sleep 1
      expect(@reports_page.element_value @reports_page.invocable_name_locator).to eql(@test_0[CoreInvocablesData::INVOCABLE_NAME.name])
      expect(@reports_page.enabled? @reports_page.invocable_name_locator).to be true
      expect(@reports_page.enabled? @reports_page.revert_button).to be false
      expect(@reports_page.exists? @reports_page.run_button).to be false

      @reports_page.edit_invocable_name_and_save("This is a new test name")
      sleep 1
      expect(@reports_page.element_value @reports_page.invocable_name_locator).not_to eq(@test_0[CoreInvocablesData::INVOCABLE_NAME.name])

      @reports_page.edit_invocable_name_and_save(@test_0[CoreInvocablesData::INVOCABLE_NAME.name])
      sleep 1
      expect(@reports_page.element_value @reports_page.invocable_name_locator).to eq(@test_0[CoreInvocablesData::INVOCABLE_NAME.name])

    end

    it 'should be able to change the description of a report' do
      @reports_page.click_invocable @test_0[CoreInvocablesData::INVOCABLE_NAME.name]
      sleep 1
      expect(@reports_page.element_value(@reports_page.invocable_description_locator).gsub(/\s+/, ' ').strip).to eql(@test_0[CoreInvocablesData::INVOCABLE_DESC.name ])
      expect(@reports_page.enabled? @reports_page.invocable_description_locator).to be true
      expect(@reports_page.enabled? @reports_page.revert_button).to be false
      expect(@reports_page.exists? @reports_page.run_button).to be false

      @reports_page.edit_description_and_save("This is a new test description")
      expect(@reports_page.element_value @reports_page.invocable_description_locator).not_to eq(@test_0[CoreInvocablesData::INVOCABLE_DESC.name])

      @reports_page.edit_description_and_save(@test_0[CoreInvocablesData::INVOCABLE_DESC.name])
      expect(@reports_page.element_value(@reports_page.invocable_description_locator).gsub(/\s+/, ' ').strip).to eq(@test_0[CoreInvocablesData::INVOCABLE_DESC.name])
    end

    it 'should not be able to alter the Jasper file associated with the report' do
      @reports_page.click_invocable @test_0[CoreInvocablesData::INVOCABLE_NAME.name]
      @reports_page.uncollapse_panel_if_collapsed CoreInvocablesData::INVOCABLE_RUNS_ON_PANEL.label

      expect(@reports_page.enabled? @reports_page.invocable_report_filename_locator).to be false
      expect(@reports_page.enabled? @reports_page.revert_button).to be false
      expect(@reports_page.exists? @reports_page.run_button).to be false
    end

    it 'should not be able to alter the report contexts' do
      @reports_page.click_invocable @test_0[CoreInvocablesData::INVOCABLE_NAME.name]
      @reports_page.uncollapse_panel_if_collapsed CoreInvocablesData::INVOCABLE_RUNS_ON_PANEL.label
      expect(@reports_page.enabled? @reports_page.invocable_no_ctx_locator).to be false
      expect(@reports_page.enabled? @reports_page.invocable_single_ctx_locator).to be false
      expect(@reports_page.enabled? @reports_page.invocable_group_ctx_locator).to be false
      expect(@reports_page.enabled? @reports_page.invocable_list_ctx_locator).to be false
      expect(@reports_page.enabled? @reports_page.revert_button).to be false
      expect(@reports_page.exists? @reports_page.run_button).to be false
    end

    it 'should not be able to alter the record types or default MIME type' do
      @reports_page.click_invocable @test_0[CoreInvocablesData::INVOCABLE_NAME.name]
      @reports_page.uncollapse_panel_if_collapsed CoreInvocablesData::INVOCABLE_RUNS_ON_PANEL.label
      expect(@reports_page.enabled? @reports_page.invocable_report_doctypes_locator).to be false
      expect(@reports_page.enabled? @reports_page.invocable_mimetype_locator).to be false
      expect(@reports_page.enabled? @reports_page.revert_button).to be false
      expect(@reports_page.exists? @reports_page.run_button).to be false
    end

    it 'should not be able to run the report' do
      @reports_page.click_invocable @test_0[CoreInvocablesData::INVOCABLE_NAME.name]
      expect(@reports_page.exists? @reports_page.run_button).to be false
    end

  end

  describe 'user with only invoking permissions interacting with the UI' do

    before(:all) do
      @search_page.click_admin_link
      @admin_page.click_users_link

      @admin_page.change_user_role(@reports_user, @edit_perms_role.name, @invoke_perms_role.name)
      # currently the UI doesn't allow us to check which role is selected...
      # expect(@admin_page.role_locator(@FULL_PERMISSIONS)).to be true
      @search_page.log_out
      @login_page.log_in(@reports_user.username, @reports_user.password)
      @search_page.click_tools_link
      @tools_page.click_reports_link
    end

    context 'checking inability to fill fields' do

      it 'should not be able to change the name of a report' do
        @search_results_page.fill_search_filter_bar(@test_0[CoreInvocablesData::INVOCABLE_NAME.name])
        @reports_page.click_invocable @test_0[CoreInvocablesData::INVOCABLE_NAME.name]
        sleep 1
        expect(@reports_page.element_value @reports_page.invocable_name_locator).to eql(@test_0[CoreInvocablesData::INVOCABLE_NAME.name])
        expect(@reports_page.enabled? @reports_page.invocable_name_locator).to be false
        expect(@reports_page.exists? @reports_page.revert_button).to be false
        expect(@reports_page.enabled? @reports_page.run_button).to be true
      end

      it 'should not be able to change the description of a report' do
        @reports_page.click_invocable @test_0[CoreInvocablesData::INVOCABLE_NAME.name]
        sleep 1
        expect(@reports_page.element_value(@reports_page.invocable_description_locator).gsub(/\s+/, ' ').strip).to eql(@test_0[CoreInvocablesData::INVOCABLE_DESC.name ])
        expect(@reports_page.enabled? @reports_page.invocable_description_locator).to be false
        expect(@reports_page.exists? @reports_page.revert_button).to be false
        expect(@reports_page.enabled? @reports_page.run_button).to be true
      end

      it 'should not be able to alter the Jasper file associated with the report' do
        @reports_page.click_invocable @test_0[CoreInvocablesData::INVOCABLE_NAME.name]
        @reports_page.uncollapse_panel_if_collapsed CoreInvocablesData::INVOCABLE_RUNS_ON_PANEL.label

        expect(@reports_page.enabled? @reports_page.invocable_report_filename_locator).to be false
        expect(@reports_page.exists? @reports_page.revert_button).to be false
        expect(@reports_page.enabled? @reports_page.run_button).to be true
      end

      it 'should not be able to alter the report contexts' do
        @reports_page.click_invocable @test_0[CoreInvocablesData::INVOCABLE_NAME.name]
        @reports_page.uncollapse_panel_if_collapsed CoreInvocablesData::INVOCABLE_RUNS_ON_PANEL.label
        expect(@reports_page.enabled? @reports_page.invocable_no_ctx_locator).to be false
        expect(@reports_page.enabled? @reports_page.invocable_single_ctx_locator).to be false
        expect(@reports_page.enabled? @reports_page.invocable_group_ctx_locator).to be false
        expect(@reports_page.enabled? @reports_page.invocable_list_ctx_locator).to be false
        expect(@reports_page.exists? @reports_page.revert_button).to be false
        expect(@reports_page.enabled? @reports_page.run_button).to be true
      end

      it 'should not be able to alter the record types or default MIME type' do
        @reports_page.click_invocable @test_0[CoreInvocablesData::INVOCABLE_NAME.name]
        @reports_page.uncollapse_panel_if_collapsed CoreInvocablesData::INVOCABLE_RUNS_ON_PANEL.label
        expect(@reports_page.enabled? @reports_page.invocable_report_doctypes_locator).to be false
        expect(@reports_page.enabled? @reports_page.invocable_mimetype_locator).to be false
        expect(@reports_page.exists? @reports_page.revert_button).to be false
        expect(@reports_page.enabled? @reports_page.run_button).to be true
      end
    end

    context 'checking ability to click the run button and dismiss modals' do
      it 'should be able to bring up a modal and dismiss it using the escape key' do
        @reports_page.click_invocable @test_0[CoreInvocablesData::INVOCABLE_NAME.name]
        expect(@reports_page.enabled? @reports_page.run_button).to be true

        @tools_page.click_run_button
        expect(@reports_page.exists? @reports_page.invocable_modal).to be true # for the modal to exist
        @reports_page.hit_escape
        expect(@reports_page.exists? @reports_page.invocable_modal).to be false
      end

      it 'should be able to bring up a modal and dismiss it using the cancel button' do
        @reports_page.click_invocable @test_0[CoreInvocablesData::INVOCABLE_NAME.name]

        expect(@reports_page.exists? @reports_page.run_button).to be true
        @tools_page.click_run_button
        expect(@reports_page.exists? @reports_page.invocable_modal).to be true # for the modal to exist
        @tools_page.click_cancel_modal_button
        expect(@reports_page.exists? @reports_page.invocable_modal).to be false
      end

      it 'should be able to bring up a modal and dismiss it using the close button' do
        @reports_page.click_invocable @test_0[CoreInvocablesData::INVOCABLE_NAME.name]
        expect(@reports_page.exists? @reports_page.run_button).to be true

        @tools_page.click_run_button
        expect(@reports_page.exists? @reports_page.invocable_modal).to be true # for the modal to exist
        @reports_page.click_close_button
        expect(@reports_page.exists? @reports_page.invocable_modal).to be false
      end
    end
  end

  describe 'user with no permissions interacting with the UI' do

    it 'should be able to change the current user role to Report Editor' do
      @search_page.click_admin_link
      @admin_page.click_users_link

      @admin_page.change_user_role(@reports_user, @invoke_perms_role.name, @no_perms_role.name)
      # currently the UI doesn't allow us to check which role is selected...
      # expect(@admin_page.role_locator(@FULL_PERMISSIONS)).to be true
      @search_page.log_out
      @login_page.log_in(@reports_user.username, @reports_user.password)
    end

    it 'should not be able to see the reports toolbar' do
      @search_page.when_exists(@search_page.admin_link, Config.short_wait)
      expect(@search_page.exists? @search_page.tools_link).to be false
    end
  end
end
