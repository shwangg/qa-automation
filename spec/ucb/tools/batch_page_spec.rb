require_relative '../../../spec_helper'

describe 'Batch' do

  include Logging
  include WebDriverManager

  test_run = TestConfig.new Deployment::PAHMA
  test_id = Time.now.to_i

  before(:all) do
    test_run.set_driver launch_browser
    @admin = test_run.get_admin_user
    @updates_user = Config.test_user test_id

    @login_page = test_run.get_page CoreLoginPage
    @create_new_page = test_run.get_page CoreCreateNewPage
    @batch_page = test_run.get_page CoreInvocablesPage
    @search_page = test_run.get_page CoreSearchPage
    @tools_page = test_run.get_page CoreToolsPage
    @admin_page = test_run.get_page CoreAdminPage
    @search_results_page = test_run.get_page CoreSearchResultsPage

    @test_0 = {
      CoreInvocablesData::INVOCABLE_NAME.name => 'Merge Authority Items',
      CoreInvocablesData::INVOCABLE_DESC.name => 'Merges two or more authority items. The "Target" record is the record that the rest of the records will be merged into.',
      CoreInvocablesData::INVOCABLE_RUNS_ON_PANEL.label => 'Runs on',
      CoreInvocablesData::INVOCABLE_BATCH_LIST_PANEL.label => 'Data Updates'
    }

    @test_1 = {
      CoreInvocablesData::INVOCABLE_NAME.name => 'A batch that doesn\'t exist',
      CoreInvocablesData::INVOCABLE_RUNS_ON_PANEL.label => 'Runs on',
    }

    @no_perms = {
      PAHMARecordTypes::USERS.name => "D",
      PAHMARecordTypes::ROLES.name => "W",
      PAHMARecordTypes::TERM_LISTS.name => "R"
    }
    @no_perms_role = UserRole.new("NO_BATCH_PERMISSIONS_#{test_id}",
                                  'No Permissions to run or invoke data updates',
                                  test_run.deployment,
                                  @no_perms)

    @full_perms = {
      PAHMARecordTypes::DATA_UPDATE_INVOC.name => "D",
      PAHMARecordTypes::DATA_UPDATES.name => "D",
      PAHMARecordTypes::USERS.name => "D",
      PAHMARecordTypes::ROLES.name => "W"
    }
    @full_perms_role = UserRole.new("CAN_EDIT_CAN_RUN_UPDATES_#{test_id}",
                                    'A role with CRUDL permissions',
                                    test_run.deployment,
                                    @full_perms)

    @invoke_perms = {
      PAHMARecordTypes::DATA_UPDATE_INVOC.name => "D",
      PAHMARecordTypes::DATA_UPDATES.name => "R",
      PAHMARecordTypes::USERS.name => "D",
      PAHMARecordTypes::ROLES.name => "W"
    }
    @invoke_perms_role = UserRole.new("CANT_EDIT_CAN_RUN_UPDATES_#{test_id}",
                                      'A role with only Invocation permissions',
                                      test_run.deployment,
                                      @invoke_perms)

    @edit_perms = {
      PAHMARecordTypes::DATA_UPDATES.name => "D",
      PAHMARecordTypes::USERS.name => "D",
      PAHMARecordTypes::ROLES.name => "W"
    }
    @edit_perms_role = UserRole.new("CAN_EDIT_CANT_RUN_UPDATES_#{test_id}",
                                    'A role with only Edit permissions',
                                    test_run.deployment,
                                    @edit_perms)

    # Initial Setup of Roles
    @login_page.load_page
    @login_page.log_in(@admin.username, @admin.password)
    @search_page.click_admin_link
    @admin_page.click_roles_link
    [@no_perms_role, @full_perms_role, @invoke_perms_role, @edit_perms_role].each { |role| @admin_page.create_user_role role }

    # Account Setup
    @updates_user.roles = [@no_perms_role]
    @admin_page.click_users_link
    @admin_page.create_new_user @updates_user
  end

  after(:all) do
    @search_page.log_out
    @login_page.log_in(@admin.username, @admin.password)
    @search_page.click_admin_link
    @admin_page.delete_user @updates_user if @admin_page.user_exists? @updates_user
    [@no_perms_role, @full_perms_role, @invoke_perms_role, @edit_perms_role].each do |role|
      @admin_page.delete_user_role role if @admin_page.role_exists? role
    end
  rescue => e
    logger.error "#{e.message}\n#{e.backtrace.join("\n")}"
  ensure
    quit_browser test_run.driver
  end

  describe 'user with editor and invoker permissions interacting with the data updates page tab' do

    before(:all) do
      @search_page.click_admin_link
      @admin_page.click_users_link

      @admin_page.change_user_role(@updates_user, @no_perms_role.name, @full_perms_role.name)
      # currently the UI doesn't allow us to check which role is selected...
      # expect(@admin_page.role_locator("CAN_EDIT_CAN_RUN")).to be true
      @search_page.log_out
      @login_page.log_in(@updates_user.username, @updates_user.password)

      @search_page.click_tools_link
      @tools_page.click_batch_link
    end

    context 'Data update UI interactions' do

      it 'should be able to filter based on a search' do
        @search_results_page.fill_search_filter_bar(@test_0[CoreInvocablesData::INVOCABLE_NAME.name])
        expect(@search_results_page.row_exists? @test_0[CoreInvocablesData::INVOCABLE_NAME.name]).to be true
        expect(@search_results_page.row_exists? @test_1[CoreInvocablesData::INVOCABLE_NAME.name]).to be false
      end

      it 'should show all results when the clear button is clicked' do
        @search_results_page.fill_search_filter_bar(@test_0[CoreInvocablesData::INVOCABLE_NAME.name])
        expect(@search_results_page.row_exists? @test_0[CoreInvocablesData::INVOCABLE_NAME.name]).to be true
        expect(@search_results_page.row_exists? @test_1[CoreInvocablesData::INVOCABLE_NAME.name]).to be false

        @tools_page.click_clear_button
        expect(@search_results_page.row_exists? @test_0[CoreInvocablesData::INVOCABLE_NAME.name]).to be true
        expect(@search_results_page.row_exists? @test_1[CoreInvocablesData::INVOCABLE_NAME.name]).to be false
      end

      it 'should be able to bring up a modal and dismiss it using the escape key' do
        @batch_page.click_invocable @test_0[CoreInvocablesData::INVOCABLE_NAME.name]

        @tools_page.click_run_button
        expect(@batch_page.exists? @batch_page.invocable_modal).to be true # for the modal to exist
        @batch_page.hit_escape
        expect(@batch_page.exists? @batch_page.invocable_modal).to be false
      end

      it 'should be able to bring up a modal and dismiss it using the cancel button' do
        @batch_page.click_invocable @test_0[CoreInvocablesData::INVOCABLE_NAME.name]

        @tools_page.click_run_button
        expect(@batch_page.exists? @batch_page.invocable_modal).to be true # for the modal to exist
        @tools_page.click_cancel_modal_button
        expect(@batch_page.exists? @batch_page.invocable_modal).to be false
      end

      it 'should be able to bring up a modal and dismiss it using the close button' do
        @batch_page.click_invocable @test_0[CoreInvocablesData::INVOCABLE_NAME.name]

        @tools_page.click_run_button
        expect(@batch_page.exists? @batch_page.invocable_modal).to be true # for the modal to exist
        @batch_page.click_close_button
        expect(@batch_page.exists? @batch_page.invocable_modal).to be false
      end
    end

    context 'checking ability to click buttons and fill fields' do

      it 'should be able to change the name of a data update' do
        @batch_page.click_invocable @test_0[CoreInvocablesData::INVOCABLE_NAME.name]
        sleep 1
        expect(@batch_page.element_value @batch_page.invocable_name_locator).to eql(@test_0[CoreInvocablesData::INVOCABLE_NAME.name])
        expect(@batch_page.enabled? @batch_page.invocable_name_locator).to be true
        expect(@batch_page.enabled? @batch_page.revert_button).to be false
        expect(@batch_page.enabled? @batch_page.run_button).to be true

        @batch_page.edit_invocable_name_and_save("This is a new test name")
        sleep 1
        expect(@batch_page.element_value @batch_page.invocable_name_locator).not_to eq(@test_0[CoreInvocablesData::INVOCABLE_NAME.name])

        @batch_page.edit_invocable_name_and_save(@test_0[CoreInvocablesData::INVOCABLE_NAME.name])
        sleep 1
        expect(@batch_page.element_value @batch_page.invocable_name_locator).to eq(@test_0[CoreInvocablesData::INVOCABLE_NAME.name])

      end

      it 'should be able to change the description of a data update' do
        @batch_page.click_invocable @test_0[CoreInvocablesData::INVOCABLE_NAME.name]
        sleep 1
        expect(@batch_page.element_value(@batch_page.invocable_description_locator).strip).to eql(@test_0[CoreInvocablesData::INVOCABLE_DESC.name])
        expect(@batch_page.enabled? @batch_page.invocable_description_locator).to be true
        expect(@batch_page.enabled? @batch_page.revert_button).to be false
        expect(@batch_page.enabled? @batch_page.run_button).to be true

        @batch_page.edit_description_and_save("This is a new test description")
        expect(@batch_page.element_value @batch_page.invocable_description_locator).not_to eq(@test_0[CoreInvocablesData::INVOCABLE_DESC.name])

        @batch_page.edit_description_and_save(@test_0[CoreInvocablesData::INVOCABLE_DESC.name])
        expect(@batch_page.element_value @batch_page.invocable_description_locator).to eq(@test_0[CoreInvocablesData::INVOCABLE_DESC.name])
      end

      it 'should not be able to alter the Java file associated with the data update' do
        @batch_page.click_invocable @test_0[CoreInvocablesData::INVOCABLE_NAME.name]
        @batch_page.uncollapse_panel_if_collapsed CoreInvocablesData::INVOCABLE_RUNS_ON_PANEL.label

        expect(@batch_page.enabled? @batch_page.invocable_classname_locator).to be false
        expect(@batch_page.enabled? @batch_page.revert_button).to be false
        expect(@batch_page.enabled? @batch_page.run_button).to be true
      end

      it 'should not be able to alter the data update contexts' do
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
        expect(@batch_page.enabled? @batch_page.invocable_batch_doctypes_locator).to be false
        expect(@batch_page.enabled? @batch_page.revert_button).to be false
        expect(@batch_page.enabled? @batch_page.run_button).to be true
      end
    end
  end

  describe 'A user with only edit permissions interacting with the UI' do

    before(:all) do
      @search_page.click_admin_link
      @admin_page.click_users_link

      @updates_user.roles = [@edit_perms]
      @admin_page.change_user_role(@updates_user, @full_perms_role.name, @edit_perms_role.name)
      # currently the UI doesn't allow us to check which role is selected...
      # expect(@admin_page.role_locator("CAN_EDIT_CAN_RUN")).to be true
      @search_page.log_out
      @login_page.log_in(@updates_user.username, @updates_user.password)

      @search_page.click_tools_link
      @tools_page.click_batch_link
    end

    it 'should be able to change the name of a report' do
      @batch_page.click_invocable @test_0[CoreInvocablesData::INVOCABLE_NAME.name]
      sleep 1
      expect(@batch_page.element_value @batch_page.invocable_name_locator).to eql(@test_0[CoreInvocablesData::INVOCABLE_NAME.name])
      expect(@batch_page.enabled? @batch_page.invocable_name_locator).to be true
      expect(@batch_page.enabled? @batch_page.revert_button).to be false
      expect(@batch_page.exists? @batch_page.run_button).to be false

      @batch_page.edit_invocable_name_and_save("This is a new test name")
      sleep 1
      expect(@batch_page.element_value @batch_page.invocable_name_locator).not_to eq(@test_0[CoreInvocablesData::INVOCABLE_NAME.name])

      @batch_page.edit_invocable_name_and_save(@test_0[CoreInvocablesData::INVOCABLE_NAME.name])
      sleep 1
      expect(@batch_page.element_value @batch_page.invocable_name_locator).to eq(@test_0[CoreInvocablesData::INVOCABLE_NAME.name])
    end

    it 'should be able to change the description of a report' do
      @batch_page.click_invocable @test_0[CoreInvocablesData::INVOCABLE_NAME.name]
      sleep 1
      expect(@batch_page.element_value(@batch_page.invocable_description_locator).strip).to eql(@test_0[CoreInvocablesData::INVOCABLE_DESC.name])
      expect(@batch_page.enabled? @batch_page.invocable_description_locator).to be true
      expect(@batch_page.enabled? @batch_page.revert_button).to be false
      expect(@batch_page.exists? @batch_page.run_button).to be false

      @batch_page.edit_description_and_save("This is a new test description")
      expect(@batch_page.element_value @batch_page.invocable_description_locator).not_to eq(@test_0[CoreInvocablesData::INVOCABLE_DESC.name])

      @batch_page.edit_description_and_save(@test_0[CoreInvocablesData::INVOCABLE_DESC.name])
      expect(@batch_page.element_value @batch_page.invocable_description_locator).to eq(@test_0[CoreInvocablesData::INVOCABLE_DESC.name])
    end

    it 'should not be able to alter the Java class associated with the report' do
      @batch_page.click_invocable @test_0[CoreInvocablesData::INVOCABLE_NAME.name]
      @batch_page.uncollapse_panel_if_collapsed CoreInvocablesData::INVOCABLE_RUNS_ON_PANEL.label

      expect(@batch_page.enabled? @batch_page.invocable_classname_locator).to be false
      expect(@batch_page.enabled? @batch_page.revert_button).to be false
      expect(@batch_page.exists? @batch_page.run_button).to be false
    end

    it 'should not be able to alter the report contexts' do
      @batch_page.click_invocable @test_0[CoreInvocablesData::INVOCABLE_NAME.name]
      @batch_page.uncollapse_panel_if_collapsed CoreInvocablesData::INVOCABLE_RUNS_ON_PANEL.label
      expect(@batch_page.enabled? @batch_page.invocable_no_ctx_locator).to be false
      expect(@batch_page.enabled? @batch_page.invocable_single_ctx_locator).to be false
      expect(@batch_page.enabled? @batch_page.invocable_group_ctx_locator).to be false
      expect(@batch_page.enabled? @batch_page.invocable_list_ctx_locator).to be false
      expect(@batch_page.enabled? @batch_page.revert_button).to be false
      expect(@batch_page.exists? @batch_page.run_button).to be false
    end

    it 'should not be able to alter the record types' do
      @batch_page.click_invocable @test_0[CoreInvocablesData::INVOCABLE_NAME.name]
      @batch_page.uncollapse_panel_if_collapsed CoreInvocablesData::INVOCABLE_RUNS_ON_PANEL.label
      expect(@batch_page.enabled? @batch_page.invocable_batch_doctypes_locator).to be false
      expect(@batch_page.enabled? @batch_page.revert_button).to be false
      expect(@batch_page.exists? @batch_page.run_button).to be false
    end

    it 'should not be able to run the report' do
      @batch_page.click_invocable @test_0[CoreInvocablesData::INVOCABLE_NAME.name]
      expect(@batch_page.exists? @batch_page.run_button).to be false
    end

  end

  describe 'A user with only invoking permissions interacting with the UI' do

    before(:all) do
      @search_page.click_admin_link
      @admin_page.click_users_link

      @updates_user.roles = [@invoke_perms_role]
      @admin_page.change_user_role(@updates_user, @edit_perms_role.name, @invoke_perms_role.name)
      # currently the UI doesn't allow us to check which role is selected...
      # expect(@admin_page.role_locator("CAN_EDIT_CAN_RUN")).to be true
      @search_page.log_out
      @login_page.log_in(@updates_user.username, @updates_user.password)

      @search_page.click_tools_link
      @tools_page.click_batch_link
    end

    context 'checking inability to fill fields' do

      it 'should not be able to change the name of a report' do
        @batch_page.click_invocable @test_0[CoreInvocablesData::INVOCABLE_NAME.name]
        sleep 1
        expect(@batch_page.element_value @batch_page.invocable_name_locator).to eql(@test_0[CoreInvocablesData::INVOCABLE_NAME.name])
        expect(@batch_page.enabled? @batch_page.invocable_name_locator).to be false
        expect(@batch_page.exists? @batch_page.revert_button).to be false
        expect(@batch_page.enabled? @batch_page.run_button).to be true
      end

      it 'should not be able to change the description of a report' do
        @batch_page.click_invocable @test_0[CoreInvocablesData::INVOCABLE_NAME.name]
        sleep 1
        expect(@batch_page.element_value(@batch_page.invocable_description_locator).strip).to eql(@test_0[CoreInvocablesData::INVOCABLE_DESC.name])
        expect(@batch_page.enabled? @batch_page.invocable_description_locator).to be false
        expect(@batch_page.exists? @batch_page.revert_button).to be false
        expect(@batch_page.enabled? @batch_page.run_button).to be true
      end

      it 'should not be able to alter the Jasper file associated with the data update' do
        @batch_page.click_invocable @test_0[CoreInvocablesData::INVOCABLE_NAME.name]
        @batch_page.uncollapse_panel_if_collapsed CoreInvocablesData::INVOCABLE_RUNS_ON_PANEL.label

        expect(@batch_page.enabled? @batch_page.invocable_classname_locator).to be false
        expect(@batch_page.exists? @batch_page.revert_button).to be false
        expect(@batch_page.enabled? @batch_page.run_button).to be true
      end

      it 'should not be able to alter the report contexts' do
        @batch_page.click_invocable @test_0[CoreInvocablesData::INVOCABLE_NAME.name]
        @batch_page.uncollapse_panel_if_collapsed CoreInvocablesData::INVOCABLE_RUNS_ON_PANEL.label
        expect(@batch_page.enabled? @batch_page.invocable_no_ctx_locator).to be false
        expect(@batch_page.enabled? @batch_page.invocable_single_ctx_locator).to be false
        expect(@batch_page.enabled? @batch_page.invocable_group_ctx_locator).to be false
        expect(@batch_page.enabled? @batch_page.invocable_list_ctx_locator).to be false
        expect(@batch_page.exists? @batch_page.revert_button).to be false
        expect(@batch_page.enabled? @batch_page.run_button).to be true
      end

      it 'should not be able to alter the record types' do
        @batch_page.click_invocable @test_0[CoreInvocablesData::INVOCABLE_NAME.name]
        @batch_page.uncollapse_panel_if_collapsed CoreInvocablesData::INVOCABLE_RUNS_ON_PANEL.label
        expect(@batch_page.enabled? @batch_page.invocable_batch_doctypes_locator).to be false
        expect(@batch_page.exists? @batch_page.revert_button).to be false
        expect(@batch_page.enabled? @batch_page.run_button).to be true
      end
    end

    context 'checking ability to click the run button and dismiss modals' do
      it 'should be able to bring up a modal and dismiss it using the escape key' do
        @batch_page.click_invocable @test_0[CoreInvocablesData::INVOCABLE_NAME.name]
        expect(@batch_page.enabled? @batch_page.run_button).to be true

        @tools_page.click_run_button
        expect(@batch_page.exists? @batch_page.invocable_modal).to be true # for the modal to exist
        @batch_page.hit_escape
        expect(@batch_page.exists? @batch_page.invocable_modal).to be false
      end

      it 'should be able to bring up a modal and dismiss it using the cancel button' do
        @batch_page.click_invocable @test_0[CoreInvocablesData::INVOCABLE_NAME.name]

        expect(@batch_page.exists? @batch_page.run_button).to be true
        @tools_page.click_run_button
        expect(@batch_page.exists? @batch_page.invocable_modal).to be true # for the modal to exist
        @tools_page.click_cancel_modal_button
        expect(@batch_page.exists? @batch_page.invocable_modal).to be false
      end

      it 'should be able to bring up a modal and dismiss it using the close button' do
        @batch_page.click_invocable @test_0[CoreInvocablesData::INVOCABLE_NAME.name]
        expect(@batch_page.exists? @batch_page.run_button).to be true

        @tools_page.click_run_button
        expect(@batch_page.exists? @batch_page.invocable_modal).to be true # for the modal to exist
        @batch_page.click_close_button
        expect(@batch_page.exists? @batch_page.invocable_modal).to be false
      end
    end
  end

  describe 'A user with no permissions interacting with the UI' do

    before(:all) do
      @search_page.click_admin_link
      @admin_page.click_users_link

      @admin_page.change_user_role(@updates_user, @invoke_perms_role.name, @no_perms_role.name)
      # currently the UI doesn't allow us to check which role is selected...
      # expect(@admin_page.role_locator(@NO_PERMISSIONS)).to be true
      @search_page.log_out
      @login_page.log_in(@updates_user.username, @updates_user.password)
    end

    it 'should not be able to see the data updates toolbar' do
      @search_page.click_tools_link
      expect(@tools_page.exists? @tools_page.batch_link).to be false
    end
  end
end

