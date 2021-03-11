require_relative '../../../spec_helper'

[Deployment::CORE_UCB, Deployment::PAHMA].each do |deploy|

  describe "#{deploy.name} Condition Check" do

    include Logging
    include WebDriverManager

    before(:all) do
      @test = TestConfig.new deploy
      @test.set_driver launch_browser
      @admin = @test.get_admin_user
      @login_page = LoginPage.new @test
      @create_new_page = CreateNewPage.new @test
      @condition_page = ConditionCheckPage.new @test
      @search_page = SearchPage.new @test
      @search_results_page = SearchResultsPage.new @test
      cond_1 = (deploy == Deployment::PAHMA) ? 'very good' : 'needs no work'
      cond_2 = (deploy == Deployment::PAHMA) ? 'poor' : 'in jeopardy'

      @test_0 = {
          CoreConditionCheckData::COND_CHECK_DATE.name => (Date.today - 1).to_s,
          CoreConditionCheckData::OBJ_AUDIT_CATEGORY.name => 'low',
          CoreConditionCheckData::CONS_TREATMENT_PRIORITY.name => 'low',
          CoreConditionCheckData::NXT_COND_CHECK_DATE.name => (Date.today - 1).to_s,
          CoreConditionCheckData::COND_CHECK_GRP_LIST.name => [{CoreConditionCheckData::COND_DESC.name => cond_1}],
          CoreConditionCheckData::COND_NOTE.name => 'textbook'
      }
      @test_1 = {
          CoreConditionCheckData::COND_CHECK_GRP_LIST.name => [{CoreConditionCheckData::COND_DESC.name => cond_1}],
          CoreConditionCheckData::COND_NOTE.name => 'testtest'
      }
      @test_2 = {
          CoreConditionCheckData::COND_CHECK_GRP_LIST.name => [{CoreConditionCheckData::COND_DESC.name => cond_1}],
          CoreConditionCheckData::COND_NOTE.name => 'testtest'
      }
      @test_3 = {
          CoreConditionCheckData::COND_CHECK_GRP_LIST.name => [{CoreConditionCheckData::COND_DESC.name => cond_2}],
          CoreConditionCheckData::COND_NOTE.name => 'testtest'
      }

      if deploy == Deployment::PAHMA
        [@test_1, @test_2, @test_3].each { |t| t.merge!({CoreConditionCheckData::COND_CHECK_DATE.name => (Date.today - 1).to_s}) }
      end

      @login_page.load_page
      @login_page.log_in(@admin.username, @admin.password)

      [@test_0, @test_1, @test_2, @test_3].each do |test|
        @test.set_unique_test_id(test, CoreConditionCheckData::COND_REF_NUM.name)
        @search_page.click_create_new_link
        @create_new_page.click_create_new_condition_check
        if deploy == Deployment::PAHMA
          @condition_page.create_new_pahma_condition_check test
        else
          @condition_page.create_new_condition_check test
        end
      end
    end

    after(:all) { quit_browser @test.driver }

    describe 'advanced search fields' do

      unless deploy == Deployment::PAHMA
        it 'allow a search by object audit' do
          @search_page.load_search_condition_check_form
          @search_page.select_object_audit_category @test_0
          @search_page.click_search_button
          @search_results_page.wait_for_results
          expect(@search_results_page.field_condition_present? @test_0[CoreConditionCheckData::OBJ_AUDIT_CATEGORY.name]).to be true
          expect(@search_results_page.row_exists? @test_0[CoreConditionCheckData::COND_REF_NUM.name]).to be true
        end
      end

      it 'allow a search by reference number' do
        @search_page.load_search_condition_check_form
        @search_page.enter_condition_ref_num @test_0
        @search_page.hit_enter
        @search_results_page.wait_for_results
        expect(@search_results_page.field_condition_present? @test_0[CoreConditionCheckData::COND_REF_NUM.name]).to be true
        expect(@search_results_page.row_exists? @test_0[CoreConditionCheckData::COND_REF_NUM.name]).to be true
      end

      it 'allow a search by condition date' do
        @search_page.load_search_condition_check_form
        @search_page.enter_condition_date @test_0
        @search_page.click_search_button
        @search_results_page.wait_for_results
        expect(@search_results_page.field_condition_present? @test_0[CoreConditionCheckData::COND_CHECK_DATE.name]).to be true
        expect(@search_results_page.row_exists? @test_0[CoreConditionCheckData::COND_REF_NUM.name]).to be true
      end

      it 'allow a search by conservation treatment priority' do
        @search_page.load_search_condition_check_form
        @search_page.select_conservation_treatment_priority @test_0
        @search_page.click_search_button
        @search_results_page.wait_for_results
        expect(@search_results_page.field_condition_present? @test_0[CoreConditionCheckData::CONS_TREATMENT_PRIORITY.name]).to be true
        expect(@search_results_page.row_exists? @test_0[CoreConditionCheckData::COND_REF_NUM.name]).to be true
      end

      it 'allow a search by next check date' do
        @search_page.load_search_condition_check_form
        @search_page.enter_next_check_date @test_0
        @search_page.click_search_button
        @search_results_page.wait_for_results
        expect(@search_results_page.field_condition_present? @test_0[CoreConditionCheckData::NXT_COND_CHECK_DATE.name]).to be true
        expect(@search_results_page.row_exists? @test_0[CoreConditionCheckData::COND_REF_NUM.name]).to be true
      end

      it 'allow a search by condition description' do
        @search_page.load_search_condition_check_form
        @search_page.select_condition_description @test_0
        @search_page.click_search_button
        @search_results_page.wait_for_results
        expect(@search_results_page.field_condition_present? @test_0[CoreConditionCheckData::COND_CHECK_GRP_LIST.name].first[CoreConditionCheckData::COND_DESC.name]).to be true
        expect(@search_results_page.row_exists? @test_0[CoreConditionCheckData::COND_REF_NUM.name]).to be true
      end

      it 'allow a search by updated date' do
        @search_page.load_search_condition_check_form
        today = Date.today.to_s
        @search_page.enter_last_updated_times(today, today)
        @search_page.click_search_button
        @search_results_page.wait_for_results
        expect(@search_results_page.field_condition_present? today).to be true
        expect(@search_results_page.row_exists? @test_0[CoreConditionCheckData::COND_REF_NUM.name]).to be true
      end

      it 'allow a search by updated by' do
        @search_page.load_search_condition_check_form
        @search_page.enter_last_updated_by [@admin.username]
        @search_page.click_search_button
        @search_results_page.wait_for_results
        expect(@search_results_page.field_condition_present? @admin.username).to be true
        expect(@search_results_page.row_exists? @test_0[CoreConditionCheckData::COND_REF_NUM.name]).to be true
      end
    end

    describe 'boolean field-based search' do

      it 'returns results matching any conditions' do
        @search_page.load_search_condition_check_form
        @search_page.select_adv_search_any_option
        @search_page.enter_next_check_date @test_0
        @search_page.select_condition_description @test_1
        @search_page.click_search_button
        @search_results_page.wait_for_results
        expect(@search_results_page.field_condition_present? @test_0[CoreConditionCheckData::NXT_COND_CHECK_DATE.name]).to be true
        expect(@search_results_page.field_condition_present? @test_1[CoreConditionCheckData::COND_CHECK_GRP_LIST.name].first[CoreConditionCheckData::COND_DESC.name]).to be true
        expect(@search_results_page.row_exists? @test_0[CoreConditionCheckData::COND_REF_NUM.name]).to be true
        expect(@search_results_page.row_exists? @test_1[CoreConditionCheckData::COND_REF_NUM.name]).to be true
        expect(@search_results_page.row_exists? @test_2[CoreConditionCheckData::COND_REF_NUM.name]).to be true
        expect(@search_results_page.row_exists? @test_3[CoreConditionCheckData::COND_REF_NUM.name]).to be false
      end

      it 'returns results matching all conditions' do
        @search_page.load_search_condition_check_form
        @search_page.select_adv_search_all_option
        @search_page.enter_next_check_date @test_0
        @search_page.select_condition_description @test_1
        @search_page.click_search_button
        @search_results_page.wait_for_results
        expect(@search_results_page.field_condition_present? @test_0[CoreConditionCheckData::NXT_COND_CHECK_DATE.name]).to be true
        expect(@search_results_page.field_condition_present? @test_1[CoreConditionCheckData::COND_CHECK_GRP_LIST.name].first[CoreConditionCheckData::COND_DESC.name]).to be true
        expect(@search_results_page.row_exists? @test_0[CoreConditionCheckData::COND_REF_NUM.name]).to be true
        expect(@search_results_page.row_exists? @test_1[CoreConditionCheckData::COND_REF_NUM.name]).to be false
        expect(@search_results_page.row_exists? @test_2[CoreConditionCheckData::COND_REF_NUM.name]).to be false
        expect(@search_results_page.row_exists? @test_3[CoreConditionCheckData::COND_REF_NUM.name]).to be false
      end
    end

    describe 'boolean field-based and keyword search' do

      it 'returns results matching any conditions' do
        @search_page.load_search_condition_check_form
        @search_page.select_adv_search_any_option
        @search_page.enter_keyword @test_1[CoreConditionCheckData::COND_NOTE.name]
        @search_page.select_condition_description @test_1
        @search_page.click_search_button
        @search_results_page.wait_for_results
        expect(@search_results_page.keyword_condition_present? @test_1[CoreConditionCheckData::COND_NOTE.name]).to be true
        expect(@search_results_page.field_condition_present? @test_1[CoreConditionCheckData::COND_CHECK_GRP_LIST.name].first[CoreConditionCheckData::COND_DESC.name]).to be true
        expect(@search_results_page.row_exists? @test_0[CoreConditionCheckData::COND_REF_NUM.name]).to be false
        expect(@search_results_page.row_exists? @test_1[CoreConditionCheckData::COND_REF_NUM.name]).to be true
        expect(@search_results_page.row_exists? @test_2[CoreConditionCheckData::COND_REF_NUM.name]).to be true
        expect(@search_results_page.row_exists? @test_3[CoreConditionCheckData::COND_REF_NUM.name]).to be false
      end

      it 'returns results matching all conditions' do
        @search_page.load_search_condition_check_form
        @search_page.select_adv_search_all_option
        @search_page.enter_keyword @test_1[CoreConditionCheckData::COND_NOTE.name]
        @search_page.select_condition_description @test_1
        @search_page.click_search_button
        @search_results_page.wait_for_results
        expect(@search_results_page.keyword_condition_present? @test_1[CoreConditionCheckData::COND_NOTE.name]).to be true
        expect(@search_results_page.field_condition_present? @test_1[CoreConditionCheckData::COND_CHECK_GRP_LIST.name].first[CoreConditionCheckData::COND_DESC.name]).to be true
        expect(@search_results_page.row_exists? @test_0[CoreConditionCheckData::COND_REF_NUM.name]).to be false
        expect(@search_results_page.row_exists? @test_1[CoreConditionCheckData::COND_REF_NUM.name]).to be true
        expect(@search_results_page.row_exists? @test_2[CoreConditionCheckData::COND_REF_NUM.name]).to be true
        expect(@search_results_page.row_exists? @test_3[CoreConditionCheckData::COND_REF_NUM.name]).to be false
      end

    end
  end
end