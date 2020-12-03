require_relative '../spec_helper'

describe 'Cataloging' do

  include Logging
  include WebDriverManager

  test_run = TestConfig.new
  test_id = Time.now.to_i

  before(:all) do
    test_run.set_driver launch_browser
    @admin = test_run.get_admin_user
    @login_page = test_run.get_page CoreLoginPage
    @create_new_page = test_run.get_page CoreCreateNewPage
    @conservation_page = test_run.get_page CoreConservationPage
    @search_page = test_run.get_page CoreSearchPage
    @search_results_page = test_run.get_page CoreSearchResultsPage

    @test_0 = {
      CoreConservationData::CONS_REF_NUM.name => 'QA TEST CONSERVATION ALL FIELDS',
      CoreConservationData::STATUS_GROUP.name => [{CoreConservationData::STATUS.name => "Analysis complete", CoreConservationData::STATUS_DATE.name => 1/1/2000}],
      CoreConservationData::CONSERVATOR.name => 'QA TEST PERSON 1',
      CoreConservationData::EXAMINATION_GROUP.name => [{CoreConservationData::EXAMINATION_NOTE.name => "QA TEST"}]
    }
    @test_1 = {
      CoreConservationData::CONS_REF_NUM.name => 'QA TEST 5 CONS BOOLEAN 1',
      CoreConservationData::EXAMINATION_GROUP.name => [{CoreConservationData::EXAMINATION_NOTE.name => "thank you"}],
      CoreConservationData::TREATMENT_PURPOSE.name => 'Damage',
      CoreConservationData::FABRIC_NOTE.name => 'testtest'
    }
    @test_2 = {
      CoreConservationData::CONS_REF_NUM.name => 'QA TEST 5 CONS BOOLEAN 2',
      CoreConservationData::EXAMINATION_GROUP.name => [{CoreConservationData::EXAMINATION_NOTE.name => "thank you"}],
      CoreConservationData::TREATMENT_PURPOSE.name => 'Damage',
      CoreConservationData::PROPOSED_TREATMENT.name => 'testtest'
    }
    @test_3 = {
      CoreConservationData::CONS_REF_NUM.name => 'QA TEST 5 CONS BOOLEAN 3',
      CoreConservationData::EXAMINATION_GROUP.name => [{CoreConservationData::EXAMINATION_NOTE.name => "thank you"}],
      CoreConservationData::TREATMENT_SUMMARY.name => 'testtest'
    }
    @test_4 = {
      CoreConservationData::CONS_REF_NUM.name => 'QA TEST 9 CONS GROUP 1',
      CoreConservationData::STATUS_GROUP.name => [{CoreConservationData::STATUS.name => "Analysis complete", CoreConservationData::STATUS_DATE.name => 1/1/2000}]
    }
    @test_5 = {
      CoreConservationData::CONS_REF_NUM.name => 'QA TEST 9 CONS GROUP 2',
      CoreConservationData::STATUS_GROUP.name => [{CoreConservationData::STATUS.name => "Analysis complete", CoreConservationData::STATUS_DATE.name => 1/1/2000}]
    }
    @test_6 = {
      CoreConservationData::CONS_REF_NUM.name => 'QA TEST 9 CONS GROUP 3',
      CoreConservationData::STATUS_GROUP.name => [{CoreConservationData::STATUS.name => "Analysis complete"}]
    }

    @login_page.load_page
    @login_page.log_in(@admin.username, @admin.password)

    [@test_0, @test_1, @test_2, @test_3, @test_4, @test_5, @test_6].each do |test|
      @search_page.click_create_new_link
      @create_new_page.click_create_new_conservation
      @conservation_page.create_new_conservation test
    end
  end

  after(:all) { quit_browser test_run.driver }

  describe 'advanced search fields' do

    it 'allow a search by reference number' do
      @search_page.load_search_conservation_form
      @search_page.enter_conservation_ref_num @test_0
      @search_page.click_search_button
      @search_results_page.wait_for_results
      expect(@search_results_page.field_condition_present? @test_0[CoreConservationData::CONS_REF_NUM.name]).to be true
      expect(@search_results_page.row_exists? @test_0[CoreConservationData::CONS_REF_NUM.name]).to be true
    end

    it 'allow a search by procedural status' do
      @search_page.load_search_conservation_form
      @search_page.select_procedural_status @test_0
      @search_page.hit_enter
      @search_results_page.wait_for_results
      expect(@search_results_page.field_condition_present? @test_0[CoreConservationData::STATUS_GROUP.name].first[CoreConservationData::STATUS.name]).to be true
      expect(@search_results_page.row_exists? @test_0[CoreConservationData::CONS_REF_NUM.name]).to be true
    end

    it 'allow a search by procedural status date' do
      @search_page.load_search_conservation_form
      @search_page.add_single_field('Procedural status date', 'is')
      @search_page.enter_procedural_status_date @test_0
      @search_page.click_search_button
      @search_results_page.wait_for_results
      expect(@search_results_page.field_condition_present? '2000-01-01').to be true
      expect(@search_results_page.row_exists? @test_0[CoreConservationData::CONS_REF_NUM.name]).to be true
    end

    it 'allow a search by conservator' do
      @search_page.load_search_conservation_form
      @search_page.select_conservator @test_0
      @search_page.click_search_button
      @search_results_page.wait_for_results
      expect(@search_results_page.field_condition_present? @test_0[CoreConservationData::CONSERVATOR.name]).to be true
      expect(@search_results_page.row_exists? @test_0[CoreConservationData::CONS_REF_NUM.name]).to be true
    end

    it 'allow a search by examination note' do
      @search_page.load_search_conservation_form
      @search_page.add_single_field('Examination note', 'contains')
      @search_page.enter_examination_note @test_0
      @search_page.click_search_button
      @search_results_page.wait_for_results
      expect(@search_results_page.field_condition_present? @test_0[CoreConservationData::EXAMINATION_GROUP.name].first[CoreConservationData::EXAMINATION_NOTE.name]).to be true
      expect(@search_results_page.row_exists? @test_0[CoreConservationData::CONS_REF_NUM.name]).to be true
    end
  end

  describe 'last updated time and last updated by' do

    it 'allow a search by updated date' do
      @search_page.load_search_conservation_form
      today = Date.today.to_s
      @search_page.enter_last_updated_times(today, today)
      @search_page.click_search_button
      @search_results_page.wait_for_results
      expect(@search_results_page.field_condition_present? today).to be true
      expect(@search_results_page.row_exists? @test_0[CoreConservationData::CONS_REF_NUM.name]).to be true
    end

    it 'allow a search by updated by' do
      @search_page.load_search_conservation_form
      @search_page.enter_last_updated_by [@admin.username]
      @search_page.click_search_button
      @search_results_page.wait_for_results
      expect(@search_results_page.field_condition_present? @admin.username).to be true
      expect(@search_results_page.row_exists? @test_0[CoreConservationData::CONS_REF_NUM.name]).to be true
    end
  end

  describe 'boolean field-based search, individual fields' do

    it 'returns results matching any conditions' do
      @search_page.load_search_conservation_form
      @search_page.select_adv_search_any_option
      @search_page.enter_examination_note @test_1
      # @search_page.scroll_to_top
      @search_page.select_treatment_purpose @test_1
      @search_page.click_search_button
      @search_results_page.wait_for_results
      expect(@search_results_page.field_condition_present? @test_1[CoreConservationData::EXAMINATION_GROUP.name].first[CoreConservationData::EXAMINATION_NOTE.name]).to be true
      expect(@search_results_page.field_condition_present? @test_1[CoreConservationData::TREATMENT_PURPOSE.name]).to be true
      expect(@search_results_page.row_exists? @test_1[CoreConservationData::CONS_REF_NUM.name]).to be true
      expect(@search_results_page.row_exists? @test_2[CoreConservationData::CONS_REF_NUM.name]).to be true
      expect(@search_results_page.row_exists? @test_3[CoreConservationData::CONS_REF_NUM.name]).to be true
    end

    it 'returns results matching all conditions' do
      @search_page.load_search_conservation_form
      @search_page.select_adv_search_all_option
      @search_page.enter_examination_note @test_1
      @search_page.select_treatment_purpose @test_1
      @search_page.click_search_button
      @search_results_page.wait_for_results
      expect(@search_results_page.field_condition_present? @test_1[CoreConservationData::EXAMINATION_GROUP.name].first[CoreConservationData::EXAMINATION_NOTE.name]).to be true
      expect(@search_results_page.field_condition_present? @test_1[CoreConservationData::TREATMENT_PURPOSE.name]).to be true
      expect(@search_results_page.row_exists? @test_1[CoreConservationData::CONS_REF_NUM.name]).to be true
      expect(@search_results_page.row_exists? @test_2[CoreConservationData::CONS_REF_NUM.name]).to be true
      expect(@search_results_page.row_exists? @test_3[CoreConservationData::CONS_REF_NUM.name]).to be false
    end
  end

  describe 'boolean field-based and keyword search' do

    it 'returns results matching any conditions' do
      @search_page.load_search_conservation_form
      @search_page.select_adv_search_any_option
      @search_page.enter_keyword @test_1[CoreConservationData::FABRIC_NOTE.name]
      @search_page.enter_examination_note @test_1
      @search_page.select_treatment_purpose @test_1
      @search_page.click_search_button
      @search_results_page.wait_for_results
      expect(@search_results_page.keyword_condition_present? @test_1[CoreConservationData::FABRIC_NOTE.name]).to be true
      expect(@search_results_page.field_condition_present? @test_1[CoreConservationData::EXAMINATION_GROUP.name].first[CoreConservationData::EXAMINATION_NOTE.name]).to be true
      expect(@search_results_page.field_condition_present? @test_1[CoreConservationData::TREATMENT_PURPOSE.name]).to be true
      expect(@search_results_page.row_exists? @test_1[CoreConservationData::CONS_REF_NUM.name]).to be true
      expect(@search_results_page.row_exists? @test_2[CoreConservationData::CONS_REF_NUM.name]).to be true
      expect(@search_results_page.row_exists? @test_3[CoreConservationData::CONS_REF_NUM.name]).to be true
    end

    it 'returns results matching all conditions' do
      @search_page.load_search_conservation_form
      @search_page.select_adv_search_all_option
      @search_page.enter_keyword @test_1[CoreConservationData::FABRIC_NOTE.name]
      @search_page.enter_examination_note @test_1
      @search_page.select_treatment_purpose @test_1
      @search_page.click_search_button
      @search_results_page.wait_for_results
      expect(@search_results_page.keyword_condition_present? @test_1[CoreConservationData::FABRIC_NOTE.name]).to be true
      expect(@search_results_page.field_condition_present? @test_1[CoreConservationData::EXAMINATION_GROUP.name].first[CoreConservationData::EXAMINATION_NOTE.name]).to be true
      expect(@search_results_page.field_condition_present? @test_1[CoreConservationData::TREATMENT_PURPOSE.name]).to be true
      expect(@search_results_page.row_exists? @test_1[CoreConservationData::CONS_REF_NUM.name]).to be true
      expect(@search_results_page.row_exists? @test_2[CoreConservationData::CONS_REF_NUM.name]).to be true
      expect(@search_results_page.row_exists? @test_3[CoreConservationData::CONS_REF_NUM.name]).to be false
    end
  end

  describe 'boolean field-based search, groups of fields' do

    it 'returns results matching all conditions' do
      @search_page.load_search_conservation_form
      @search_page.select_adv_search_all_option
      @search_page.add_single_group('Procedural status', 'All', 'Status', 'is')
      @search_page.select_from_single_group(@test_4[CoreConservationData::STATUS_GROUP.name].first[CoreConservationData::STATUS.name], 1)
      @search_page.add_field_to_group('Date', 'is', 1)
      @search_page.date_from_single_group(@test_4[CoreConservationData::STATUS_GROUP.name].first[CoreConservationData::STATUS_DATE.name], CoreConservationData::STATUS_DATE.name, 1)
      @search_page.click_search_button
      @search_results_page.wait_for_results
      expect(@search_results_page.field_condition_present? @test_4[CoreConservationData::STATUS_GROUP.name].first[CoreConservationData::STATUS.name]).to be true
      expect(@search_results_page.field_condition_present? '2000-01-01').to be true
      expect(@search_results_page.row_exists? @test_4[CoreConservationData::CONS_REF_NUM.name]).to be true
      expect(@search_results_page.row_exists? @test_5[CoreConservationData::CONS_REF_NUM.name]).to be true
      expect(@search_results_page.row_exists? @test_6[CoreConservationData::CONS_REF_NUM.name]).to be false
    end

    it 'returns results matching any conditions' do
      @search_page.load_search_conservation_form
      @search_page.select_adv_search_any_option
      @search_page.select_procedural_status @test_4
      @search_page.enter_procedural_status_date @test_4
      @search_page.click_search_button
      @search_results_page.wait_for_results
      expect(@search_results_page.field_condition_present? @test_4[CoreConservationData::STATUS_GROUP.name].first[CoreConservationData::STATUS.name]).to be true
      expect(@search_results_page.field_condition_present? '2000-01-01').to be true
      expect(@search_results_page.row_exists? @test_4[CoreConservationData::CONS_REF_NUM.name]).to be true
      expect(@search_results_page.row_exists? @test_5[CoreConservationData::CONS_REF_NUM.name]).to be true
      expect(@search_results_page.row_exists? @test_6[CoreConservationData::CONS_REF_NUM.name]).to be true
    end
  end
end
