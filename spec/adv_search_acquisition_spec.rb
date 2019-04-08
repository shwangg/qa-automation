require_relative '../spec_helper'

describe 'Acquisition' do

  include Logging
  include WebDriverManager

  test_run = TestConfig.new

  before(:all) do
    test_run.set_driver launch_browser
    @admin = test_run.get_admin_user
    @login_page = test_run.get_page LoginPage
    @create_new_page = test_run.get_page CreateNewPage
    @acquisition_page = test_run.get_page AcquisitionPage
    @search_page = test_run.get_page SearchPage
    @search_results_page = test_run.get_page SearchResultsPage

    @test_0 = {
        AcquisitionData::ACCESSION_DATE_GRP.name => (Date.today - 1).to_s,
        AcquisitionData::ACQUIS_DATE_GRP.name => [{AcquisitionData::ACQUIS_DATE.name => (Date.today - 2).to_s}],
        AcquisitionData::ACQUIS_METHOD.name => 'gift',
        AcquisitionData::ACQUIS_SOURCES.name => [{AcquisitionData::ACQUIS_SOURCE.name => 'test'}],
        AcquisitionData::ACQUIS_FUNDING_LIST.name => [{AcquisitionData::ACQUIS_FUNDING_SOURCE.name => 'test'}],
        AcquisitionData::CREDIT_LINE.name => 'textbook',
        AcquisitionData::FIELD_COLLECT_EVENT_NAMES.name => [{AcquisitionData::FIELD_COLLECT_EVENT_NAME.name => 'test field collection event name'}]
    }
    @test_1 = {
        AcquisitionData::ACQUIS_METHOD.name => 'purchase',
        AcquisitionData::CREDIT_LINE.name => 'Thank you',
        AcquisitionData::ACQUIS_REASON.name => 'testtest'
    }
    @test_2 = {
        AcquisitionData::ACQUIS_METHOD.name => 'purchase',
        AcquisitionData::CREDIT_LINE.name => 'Thank you',
        AcquisitionData::ACQUIS_NOTE.name => 'testtest'
    }
    @test_3 = {
        AcquisitionData::ACQUIS_METHOD.name => 'gift',
        AcquisitionData::CREDIT_LINE.name => 'Thank you',
        AcquisitionData::ACQUIS_PROVISOS.name => 'testtest'
    }

    @login_page.load_page
    @login_page.log_in(@admin.username, @admin.password)

    [@test_0, @test_1, @test_2, @test_3].each do |test|
      test_run.set_unique_test_id(test, AcquisitionData::ACQUIS_REF_NUM.name)
      @search_page.click_create_new_link
      @create_new_page.click_create_new_acquisition
      @acquisition_page.create_new_acquisition test
    end
  end

  after(:all) { quit_browser test_run.driver }

  describe 'advanced search fields' do

    it 'allow a search by reference number' do
      @search_page.load_search_acquisitions_form
      @search_page.enter_ref_num @test_0
      @search_page.click_search_button
      @search_results_page.wait_for_results
      expect(@search_results_page.field_condition_present? @test_0[AcquisitionData::ACQUIS_REF_NUM.name]).to be true
      expect(@search_results_page.row_exists? @test_0[AcquisitionData::ACQUIS_REF_NUM.name]).to be true
    end

    it 'allow a search by accession date' do
      @search_page.load_search_acquisitions_form
      @search_page.enter_accession_date @test_0
      @search_page.click_search_button
      @search_results_page.wait_for_results
      expect(@search_results_page.field_condition_present? @test_0[AcquisitionData::ACCESSION_DATE_GRP.name]).to be true
      expect(@search_results_page.row_exists? @test_0[AcquisitionData::ACQUIS_REF_NUM.name]).to be true
    end

    it 'allow a search by acquisition date' do
      @search_page.load_search_acquisitions_form
      @search_page.enter_acquisition_dates @test_0
      @search_page.click_search_button
      @search_results_page.wait_for_results
      expect(@search_results_page.field_condition_present? @test_0[AcquisitionData::ACQUIS_DATE_GRP.name].first[AcquisitionData::ACQUIS_DATE.name]).to be true
      expect(@search_results_page.row_exists? @test_0[AcquisitionData::ACQUIS_REF_NUM.name]).to be true
    end

    it 'allow a search by acquisition method' do
      @search_page.load_search_acquisitions_form
      @search_page.select_acquisition_method @test_0
      @search_page.click_search_button
      @search_results_page.wait_for_results
      expect(@search_results_page.field_condition_present? @test_0[AcquisitionData::ACQUIS_METHOD.name]).to be true
      expect(@search_results_page.row_exists? @test_0[AcquisitionData::ACQUIS_REF_NUM.name]).to be true
    end

    it 'allow a search by acquisition source' do
      @search_page.load_search_acquisitions_form
      @search_page.select_acquisition_sources @test_0
      @search_page.click_search_button
      @search_results_page.wait_for_results
      expect(@search_results_page.field_condition_present? @test_0[AcquisitionData::ACQUIS_SOURCES.name].first[AcquisitionData::ACQUIS_SOURCE.name]).to be true
      expect(@search_results_page.row_exists? @test_0[AcquisitionData::ACQUIS_REF_NUM.name]).to be true
    end

    it 'allow a search by acquisition funding source' do
      @search_page.load_search_acquisitions_form
      @search_page.select_funding_sources @test_0
      @search_page.click_search_button
      @search_results_page.wait_for_results
      expect(@search_results_page.field_condition_present? @test_0[AcquisitionData::ACQUIS_FUNDING_LIST.name].first[AcquisitionData::ACQUIS_FUNDING_SOURCE.name]).to be true
      expect(@search_results_page.row_exists? @test_0[AcquisitionData::ACQUIS_REF_NUM.name]).to be true
    end

    it 'allow a search by credit line' do
      @search_page.load_search_acquisitions_form
      @search_page.enter_credit_line @test_0
      @search_page.click_search_button
      @search_results_page.wait_for_results
      expect(@search_results_page.field_condition_present? @test_0[AcquisitionData::CREDIT_LINE.name]).to be true
      expect(@search_results_page.row_exists? @test_0[AcquisitionData::ACQUIS_REF_NUM.name]).to be true
    end

    it 'allow a search by field collection event name' do
      @search_page.load_search_acquisitions_form
      @search_page.enter_field_collect_event_names @test_0
      @search_page.click_search_button
      @search_results_page.wait_for_results
      expect(@search_results_page.field_condition_present? @test_0[AcquisitionData::FIELD_COLLECT_EVENT_NAMES.name].first[AcquisitionData::FIELD_COLLECT_EVENT_NAME.name]).to be true
      expect(@search_results_page.row_exists? @test_0[AcquisitionData::ACQUIS_REF_NUM.name]).to be true
    end

    it 'allow a search by updated date' do
      @search_page.load_search_acquisitions_form
      today = Date.today.to_s
      @search_page.enter_last_updated_times(today, today)
      @search_page.click_search_button
      @search_results_page.wait_for_results
      expect(@search_results_page.field_condition_present? today).to be true
      expect(@search_results_page.row_exists? @test_0[AcquisitionData::ACQUIS_REF_NUM.name]).to be true
    end

    it 'allow a search by updated by' do
      @search_page.load_search_acquisitions_form
      @search_page.enter_last_updated_by [@admin.username]
      @search_page.click_search_button
      @search_results_page.wait_for_results
      expect(@search_results_page.field_condition_present? @admin.username).to be true
      expect(@search_results_page.row_exists? @test_0[AcquisitionData::ACQUIS_REF_NUM.name]).to be true
    end
  end

  describe 'boolean field-based search' do

    it 'returns results matching any conditions' do
      @search_page.load_search_acquisitions_form
      @search_page.select_adv_search_any_option
      @search_page.enter_credit_line @test_1
      @search_page.select_acquisition_method @test_1
      @search_page.click_search_button
      @search_results_page.wait_for_results
      expect(@search_results_page.field_condition_present? @test_1[AcquisitionData::CREDIT_LINE.name]).to be true
      expect(@search_results_page.field_condition_present? @test_1[AcquisitionData::ACQUIS_METHOD.name]).to be true
      expect(@search_results_page.row_exists? @test_1[AcquisitionData::ACQUIS_REF_NUM.name]).to be true
      expect(@search_results_page.row_exists? @test_2[AcquisitionData::ACQUIS_REF_NUM.name]).to be true
      expect(@search_results_page.row_exists? @test_3[AcquisitionData::ACQUIS_REF_NUM.name]).to be true
    end

    it 'returns results matching all conditions' do
      @search_page.load_search_acquisitions_form
      @search_page.select_adv_search_all_option
      @search_page.enter_credit_line @test_1
      @search_page.select_acquisition_method @test_1
      @search_page.click_search_button
      @search_results_page.wait_for_results
      expect(@search_results_page.field_condition_present? @test_1[AcquisitionData::CREDIT_LINE.name]).to be true
      expect(@search_results_page.field_condition_present? @test_1[AcquisitionData::ACQUIS_METHOD.name]).to be true
      expect(@search_results_page.row_exists? @test_1[AcquisitionData::ACQUIS_REF_NUM.name]).to be true
      expect(@search_results_page.row_exists? @test_2[AcquisitionData::ACQUIS_REF_NUM.name]).to be true
      expect(@search_results_page.row_exists? @test_3[AcquisitionData::ACQUIS_REF_NUM.name]).to be false
    end
  end

  describe 'boolean field-based and keyword search' do

    it 'returns results matching any conditions' do
      @search_page.load_search_acquisitions_form
      @search_page.select_adv_search_any_option
      @search_page.enter_keyword @test_1[AcquisitionData::ACQUIS_REASON.name]
      @search_page.enter_credit_line @test_1
      @search_page.select_acquisition_method @test_1
      @search_page.click_search_button
      @search_results_page.wait_for_results
      expect(@search_results_page.keyword_condition_present? @test_1[AcquisitionData::ACQUIS_REASON.name]).to be true
      expect(@search_results_page.field_condition_present? @test_1[AcquisitionData::CREDIT_LINE.name]).to be true
      expect(@search_results_page.field_condition_present? @test_1[AcquisitionData::ACQUIS_METHOD.name]).to be true
      expect(@search_results_page.row_exists? @test_1[AcquisitionData::ACQUIS_REF_NUM.name]).to be true
      expect(@search_results_page.row_exists? @test_2[AcquisitionData::ACQUIS_REF_NUM.name]).to be true
      expect(@search_results_page.row_exists? @test_3[AcquisitionData::ACQUIS_REF_NUM.name]).to be true
    end

    it 'returns results matching all conditions' do
      @search_page.load_search_acquisitions_form
      @search_page.select_adv_search_all_option
      @search_page.enter_keyword @test_1[AcquisitionData::ACQUIS_REASON.name]
      @search_page.enter_credit_line @test_1
      @search_page.select_acquisition_method @test_1
      @search_page.click_search_button
      @search_results_page.wait_for_results
      expect(@search_results_page.keyword_condition_present? @test_1[AcquisitionData::ACQUIS_REASON.name]).to be true
      expect(@search_results_page.field_condition_present? @test_1[AcquisitionData::CREDIT_LINE.name]).to be true
      expect(@search_results_page.field_condition_present? @test_1[AcquisitionData::ACQUIS_METHOD.name]).to be true
      expect(@search_results_page.row_exists? @test_1[AcquisitionData::ACQUIS_REF_NUM.name]).to be true
      expect(@search_results_page.row_exists? @test_2[AcquisitionData::ACQUIS_REF_NUM.name]).to be true
      expect(@search_results_page.row_exists? @test_3[AcquisitionData::ACQUIS_REF_NUM.name]).to be false
    end

  end
end
