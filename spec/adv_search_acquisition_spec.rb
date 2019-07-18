require_relative '../spec_helper'

describe 'Acquisition' do

  include Logging
  include WebDriverManager

  test_run = TestConfig.new
  test_id = Time.now.to_i

  before(:all) do
    test_run.set_driver launch_browser
    @admin = test_run.get_admin_user
    @login_page = test_run.get_page CoreLoginPage
    @create_new_page = test_run.get_page CoreCreateNewPage
    @acquisition_page = test_run.get_page CoreAcquisitionPage
    @search_page = test_run.get_page CoreSearchPage
    @search_results_page = test_run.get_page CoreSearchResultsPage

    @test_0 = {
        CoreAcquisitionData::ACCESSION_DATE_GRP.name => (Date.today - 1).to_s,
        CoreAcquisitionData::ACQUIS_DATE_GRP.name => [{CoreAcquisitionData::ACQUIS_DATE.name => (Date.today - 2).to_s}],
        CoreAcquisitionData::ACQUIS_METHOD.name => 'gift',
        CoreAcquisitionData::ACQUIS_SOURCES.name => [{CoreAcquisitionData::ACQUIS_SOURCE.name => "Test Acquisition Source #{test_id}"}],
        CoreAcquisitionData::ACQUIS_FUNDING_LIST.name => [{CoreAcquisitionData::ACQUIS_FUNDING_SOURCE.name => "Test Funding Source #{test_id}"}],
        CoreAcquisitionData::CREDIT_LINE.name => 'textbook',
        CoreAcquisitionData::FIELD_COLLECT_EVENT_NAMES.name => [{CoreAcquisitionData::FIELD_COLLECT_EVENT_NAME.name => 'test field collection event name'}]
    }
    @test_1 = {
        CoreAcquisitionData::ACQUIS_METHOD.name => 'purchase',
        CoreAcquisitionData::CREDIT_LINE.name => 'Thank you',
        CoreAcquisitionData::ACQUIS_REASON.name => 'testtest'
    }
    @test_2 = {
        CoreAcquisitionData::ACQUIS_METHOD.name => 'purchase',
        CoreAcquisitionData::CREDIT_LINE.name => 'Thank you',
        CoreAcquisitionData::ACQUIS_NOTE.name => 'testtest'
    }
    @test_3 = {
        CoreAcquisitionData::ACQUIS_METHOD.name => 'gift',
        CoreAcquisitionData::CREDIT_LINE.name => 'Thank you',
        CoreAcquisitionData::ACQUIS_PROVISOS.name => 'testtest'
    }

    @login_page.load_page
    @login_page.log_in(@admin.username, @admin.password)

    [@test_0, @test_1, @test_2, @test_3].each do |test|
      test_run.set_unique_test_id(test, CoreAcquisitionData::ACQUIS_REF_NUM.name)
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
      @search_page.hit_enter
      @search_results_page.wait_for_results
      expect(@search_results_page.field_condition_present? @test_0[CoreAcquisitionData::ACQUIS_REF_NUM.name]).to be true
      expect(@search_results_page.row_exists? @test_0[CoreAcquisitionData::ACQUIS_REF_NUM.name]).to be true
    end

    it 'allow a search by accession date' do
      @search_page.load_search_acquisitions_form
      @search_page.enter_accession_date @test_0
      @search_page.click_search_button
      @search_results_page.wait_for_results
      expect(@search_results_page.field_condition_present? @test_0[CoreAcquisitionData::ACCESSION_DATE_GRP.name]).to be true
      expect(@search_results_page.row_exists? @test_0[CoreAcquisitionData::ACQUIS_REF_NUM.name]).to be true
    end

    it 'allow a search by acquisition date' do
      @search_page.load_search_acquisitions_form
      @search_page.enter_acquisition_dates @test_0
      @search_page.click_search_button
      @search_results_page.wait_for_results
      expect(@search_results_page.field_condition_present? @test_0[CoreAcquisitionData::ACQUIS_DATE_GRP.name].first[CoreAcquisitionData::ACQUIS_DATE.name]).to be true
      expect(@search_results_page.row_exists? @test_0[CoreAcquisitionData::ACQUIS_REF_NUM.name]).to be true
    end

    it 'allow a search by acquisition method' do
      @search_page.load_search_acquisitions_form
      @search_page.select_acquisition_method @test_0
      @search_page.click_search_button
      @search_results_page.wait_for_results
      expect(@search_results_page.field_condition_present? @test_0[CoreAcquisitionData::ACQUIS_METHOD.name]).to be true
      expect(@search_results_page.row_exists? @test_0[CoreAcquisitionData::ACQUIS_REF_NUM.name]).to be true
    end

    it 'allow a search by acquisition source' do
      @search_page.load_search_acquisitions_form
      @search_page.select_acquisition_sources @test_0
      @search_page.click_search_button
      @search_results_page.wait_for_results
      expect(@search_results_page.field_condition_present? @test_0[CoreAcquisitionData::ACQUIS_SOURCES.name].first[CoreAcquisitionData::ACQUIS_SOURCE.name]).to be true
      expect(@search_results_page.row_exists? @test_0[CoreAcquisitionData::ACQUIS_REF_NUM.name]).to be true
    end

    it 'allow a search by acquisition funding source' do
      @search_page.load_search_acquisitions_form
      @search_page.select_funding_sources @test_0
      @search_page.click_search_button
      @search_results_page.wait_for_results
      expect(@search_results_page.field_condition_present? @test_0[CoreAcquisitionData::ACQUIS_FUNDING_LIST.name].first[CoreAcquisitionData::ACQUIS_FUNDING_SOURCE.name]).to be true
      expect(@search_results_page.row_exists? @test_0[CoreAcquisitionData::ACQUIS_REF_NUM.name]).to be true
    end

    it 'allow a search by credit line' do
      @search_page.load_search_acquisitions_form
      @search_page.enter_credit_line @test_0
      @search_page.hit_enter
      @search_results_page.wait_for_results
      expect(@search_results_page.field_condition_present? @test_0[CoreAcquisitionData::CREDIT_LINE.name]).to be true
      expect(@search_results_page.row_exists? @test_0[CoreAcquisitionData::ACQUIS_REF_NUM.name]).to be true
    end

    it 'allow a search by field collection event name' do
      @search_page.load_search_acquisitions_form
      @search_page.enter_field_collect_event_names @test_0
      @search_page.click_search_button
      @search_results_page.wait_for_results
      expect(@search_results_page.field_condition_present? @test_0[CoreAcquisitionData::FIELD_COLLECT_EVENT_NAMES.name].first[CoreAcquisitionData::FIELD_COLLECT_EVENT_NAME.name]).to be true
      expect(@search_results_page.row_exists? @test_0[CoreAcquisitionData::ACQUIS_REF_NUM.name]).to be true
    end

    it 'allow a search by updated date' do
      @search_page.load_search_acquisitions_form
      today = Date.today.to_s
      @search_page.enter_last_updated_times(today, today)
      @search_page.click_search_button
      @search_results_page.wait_for_results
      expect(@search_results_page.field_condition_present? today).to be true
      expect(@search_results_page.row_exists? @test_0[CoreAcquisitionData::ACQUIS_REF_NUM.name]).to be true
    end

    it 'allow a search by updated by' do
      @search_page.load_search_acquisitions_form
      @search_page.enter_last_updated_by [@admin.username]
      @search_page.click_search_button
      @search_results_page.wait_for_results
      expect(@search_results_page.field_condition_present? @admin.username).to be true
      expect(@search_results_page.row_exists? @test_0[CoreAcquisitionData::ACQUIS_REF_NUM.name]).to be true
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
      expect(@search_results_page.field_condition_present? @test_1[CoreAcquisitionData::CREDIT_LINE.name]).to be true
      expect(@search_results_page.field_condition_present? @test_1[CoreAcquisitionData::ACQUIS_METHOD.name]).to be true
      expect(@search_results_page.row_exists? @test_1[CoreAcquisitionData::ACQUIS_REF_NUM.name]).to be true
      expect(@search_results_page.row_exists? @test_2[CoreAcquisitionData::ACQUIS_REF_NUM.name]).to be true
      expect(@search_results_page.row_exists? @test_3[CoreAcquisitionData::ACQUIS_REF_NUM.name]).to be true
    end

    it 'returns results matching all conditions' do
      @search_page.load_search_acquisitions_form
      @search_page.select_adv_search_all_option
      @search_page.enter_credit_line @test_1
      @search_page.select_acquisition_method @test_1
      @search_page.click_search_button
      @search_results_page.wait_for_results
      expect(@search_results_page.field_condition_present? @test_1[CoreAcquisitionData::CREDIT_LINE.name]).to be true
      expect(@search_results_page.field_condition_present? @test_1[CoreAcquisitionData::ACQUIS_METHOD.name]).to be true
      expect(@search_results_page.row_exists? @test_1[CoreAcquisitionData::ACQUIS_REF_NUM.name]).to be true
      expect(@search_results_page.row_exists? @test_2[CoreAcquisitionData::ACQUIS_REF_NUM.name]).to be true
      expect(@search_results_page.row_exists? @test_3[CoreAcquisitionData::ACQUIS_REF_NUM.name]).to be false
    end
  end

  describe 'boolean field-based and keyword search' do

    it 'returns results matching any conditions' do
      @search_page.load_search_acquisitions_form
      @search_page.select_adv_search_any_option
      @search_page.enter_keyword @test_1[CoreAcquisitionData::ACQUIS_REASON.name]
      @search_page.enter_credit_line @test_1
      @search_page.select_acquisition_method @test_1
      @search_page.click_search_button
      @search_results_page.wait_for_results
      expect(@search_results_page.keyword_condition_present? @test_1[CoreAcquisitionData::ACQUIS_REASON.name]).to be true
      expect(@search_results_page.field_condition_present? @test_1[CoreAcquisitionData::CREDIT_LINE.name]).to be true
      expect(@search_results_page.field_condition_present? @test_1[CoreAcquisitionData::ACQUIS_METHOD.name]).to be true
      expect(@search_results_page.row_exists? @test_1[CoreAcquisitionData::ACQUIS_REF_NUM.name]).to be true
      expect(@search_results_page.row_exists? @test_2[CoreAcquisitionData::ACQUIS_REF_NUM.name]).to be true
      expect(@search_results_page.row_exists? @test_3[CoreAcquisitionData::ACQUIS_REF_NUM.name]).to be true
    end

    it 'returns results matching all conditions' do
      @search_page.load_search_acquisitions_form
      @search_page.select_adv_search_all_option
      @search_page.enter_keyword @test_1[CoreAcquisitionData::ACQUIS_REASON.name]
      @search_page.enter_credit_line @test_1
      @search_page.select_acquisition_method @test_1
      @search_page.click_search_button
      @search_results_page.wait_for_results
      expect(@search_results_page.keyword_condition_present? @test_1[CoreAcquisitionData::ACQUIS_REASON.name]).to be true
      expect(@search_results_page.field_condition_present? @test_1[CoreAcquisitionData::CREDIT_LINE.name]).to be true
      expect(@search_results_page.field_condition_present? @test_1[CoreAcquisitionData::ACQUIS_METHOD.name]).to be true
      expect(@search_results_page.row_exists? @test_1[CoreAcquisitionData::ACQUIS_REF_NUM.name]).to be true
      expect(@search_results_page.row_exists? @test_2[CoreAcquisitionData::ACQUIS_REF_NUM.name]).to be true
      expect(@search_results_page.row_exists? @test_3[CoreAcquisitionData::ACQUIS_REF_NUM.name]).to be false
    end

  end
end
