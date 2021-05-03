require_relative '../../../spec_helper'

[Deployment::CORE_UCB, Deployment::PAHMA].each do |deploy|

  describe "#{deploy.name} Acquisition" do

    include Logging
    include WebDriverManager

    before(:all) do
      @test = TestConfig.new deploy
      test_id = Time.now.to_i
      @test.set_driver launch_browser
      @admin = @test.get_admin_user
      @login_page = LoginPage.new @test
      @create_new_page = CreateNewPage.new @test
      @acquisition_page = AcquisitionPage.new @test
      @search_page = SearchPage.new @test
      @search_results_page = SearchResultsPage.new @test

      @test_0 = {
        CoreAcquisitionData::ACCESSION_DATE_GRP.name => (Date.today - 1).to_s,
        CoreAcquisitionData::ACQUIS_DATE_GRP.name => [{ CoreAcquisitionData::ACQUIS_DATE.name => (Date.today - 2).to_s }],
        CoreAcquisitionData::ACQUIS_METHOD.name => 'gift',
        CoreAcquisitionData::ACQUIS_SOURCES.name => [{ CoreAcquisitionData::ACQUIS_SOURCE.name => "Test Acquisition Source #{test_id}" }],
        CoreAcquisitionData::ACQUIS_FUNDING_LIST.name => [{ CoreAcquisitionData::ACQUIS_FUNDING_SOURCE.name => "Test Funding Source #{test_id}" }],
        CoreAcquisitionData::CREDIT_LINE.name => 'textbook',
        CoreAcquisitionData::FIELD_COLLECT_EVENT_NAMES.name => [{ CoreAcquisitionData::FIELD_COLLECT_EVENT_NAME.name => 'test field collection event name' }]
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
        @test.set_unique_test_id(test, CoreAcquisitionData::ACQUIS_REF_NUM.name)
        @search_page.click_create_new_link
        @create_new_page.click_create_new_acquisition
        if deploy == Deployment::PAHMA
          @acquisition_page.create_new_pahma_accession test
        else
          @acquisition_page.create_new_acquisition test
        end
      end
    end

    after(:all) { quit_browser @test.driver }

    describe 'advanced search fields' do

      before(:each) { (deploy == Deployment::PAHMA) ? @search_page.load_pahma_search_accessions_form : @search_page.load_search_acquisitions_form }

      it 'allow a search by reference number' do
        @search_page.enter_ref_num @test_0
        @search_page.hit_enter_and_wait_for_results @search_results_page
        expect(@search_results_page.field_condition_present? @test_0[CoreAcquisitionData::ACQUIS_REF_NUM.name]).to be true
        expect(@search_results_page.row_exists? @test_0[CoreAcquisitionData::ACQUIS_REF_NUM.name]).to be true
      end

      it 'allow a search by accession date' do
        @search_page.enter_accession_date @test_0
        @search_page.click_search_and_wait_for_results @search_results_page
        expect(@search_results_page.field_condition_present? @test_0[CoreAcquisitionData::ACCESSION_DATE_GRP.name]).to be true
        expect(@search_results_page.row_exists? @test_0[CoreAcquisitionData::ACQUIS_REF_NUM.name]).to be true
      end

      it 'allow a search by acquisition date' do
        @search_page.enter_acquisition_dates @test_0
        @search_page.click_search_and_wait_for_results @search_results_page
        expect(@search_results_page.field_condition_present? @test_0[CoreAcquisitionData::ACQUIS_DATE_GRP.name].first[CoreAcquisitionData::ACQUIS_DATE.name]).to be true
        expect(@search_results_page.row_exists? @test_0[CoreAcquisitionData::ACQUIS_REF_NUM.name]).to be true
      end

      it 'allow a search by acquisition method' do
        @search_page.select_acquisition_method @test_0
        @search_page.click_search_and_wait_for_results @search_results_page
        expect(@search_results_page.field_condition_present? @test_0[CoreAcquisitionData::ACQUIS_METHOD.name]).to be true
        expect(@search_results_page.row_exists? @test_0[CoreAcquisitionData::ACQUIS_REF_NUM.name]).to be true
      end

      it 'allow a search by acquisition source' do
        @search_page.select_acquisition_sources @test_0
        @search_page.click_search_and_wait_for_results @search_results_page
        expect(@search_results_page.field_condition_present? @test_0[CoreAcquisitionData::ACQUIS_SOURCES.name].first[CoreAcquisitionData::ACQUIS_SOURCE.name]).to be true
        expect(@search_results_page.row_exists? @test_0[CoreAcquisitionData::ACQUIS_REF_NUM.name]).to be true
      end

      unless deploy == Deployment::PAHMA
        it 'allow a search by acquisition funding source' do
          @search_page.select_funding_sources @test_0
          @search_page.click_search_and_wait_for_results @search_results_page
          expect(@search_results_page.field_condition_present? @test_0[CoreAcquisitionData::ACQUIS_FUNDING_LIST.name].first[CoreAcquisitionData::ACQUIS_FUNDING_SOURCE.name]).to be true
          expect(@search_results_page.row_exists? @test_0[CoreAcquisitionData::ACQUIS_REF_NUM.name]).to be true
        end
      end

      it 'allow a search by credit line' do
        @search_page.enter_credit_line @test_0
        @search_page.hit_enter_and_wait_for_results @search_results_page
        expect(@search_results_page.field_condition_present? @test_0[CoreAcquisitionData::CREDIT_LINE.name]).to be true
        expect(@search_results_page.row_exists? @test_0[CoreAcquisitionData::ACQUIS_REF_NUM.name]).to be true
      end

      it 'allow a search by field collection event name' do
        @search_page.enter_field_collect_event_names @test_0
        @search_page.click_search_and_wait_for_results @search_results_page
        expect(@search_results_page.field_condition_present? @test_0[CoreAcquisitionData::FIELD_COLLECT_EVENT_NAMES.name].first[CoreAcquisitionData::FIELD_COLLECT_EVENT_NAME.name]).to be true
        expect(@search_results_page.row_exists? @test_0[CoreAcquisitionData::ACQUIS_REF_NUM.name]).to be true
      end

      it 'allow a search by updated date' do
        today = Date.today.to_s
        @search_page.enter_last_updated_times(today, today)
        @search_page.click_search_and_wait_for_results @search_results_page
        expect(@search_results_page.field_condition_present? today).to be true
        expect(@search_results_page.row_exists? @test_0[CoreAcquisitionData::ACQUIS_REF_NUM.name]).to be true
      end

      it 'allow a search by updated by' do
        @search_page.enter_last_updated_by [@admin.username]
        @search_page.click_search_and_wait_for_results @search_results_page
        expect(@search_results_page.field_condition_present? @admin.username).to be true
        expect(@search_results_page.row_exists? @test_0[CoreAcquisitionData::ACQUIS_REF_NUM.name]).to be true
      end
    end

    describe 'boolean field-based search' do

      before(:each) { (deploy == Deployment::PAHMA) ? @search_page.load_pahma_search_accessions_form : @search_page.load_search_acquisitions_form }

      it 'returns results matching any conditions' do
        @search_page.select_adv_search_any_option
        @search_page.enter_credit_line @test_1
        @search_page.select_acquisition_method @test_1
        @search_page.click_search_and_wait_for_results @search_results_page
        expect(@search_results_page.field_condition_present? @test_1[CoreAcquisitionData::CREDIT_LINE.name]).to be true
        expect(@search_results_page.field_condition_present? @test_1[CoreAcquisitionData::ACQUIS_METHOD.name]).to be true
        expect(@search_results_page.row_exists? @test_1[CoreAcquisitionData::ACQUIS_REF_NUM.name]).to be true
        expect(@search_results_page.row_exists? @test_2[CoreAcquisitionData::ACQUIS_REF_NUM.name]).to be true
        expect(@search_results_page.row_exists? @test_3[CoreAcquisitionData::ACQUIS_REF_NUM.name]).to be true
      end

      it 'returns results matching all conditions' do
        @search_page.select_adv_search_all_option
        @search_page.enter_credit_line @test_1
        @search_page.select_acquisition_method @test_1
        @search_page.click_search_and_wait_for_results @search_results_page
        expect(@search_results_page.field_condition_present? @test_1[CoreAcquisitionData::CREDIT_LINE.name]).to be true
        expect(@search_results_page.field_condition_present? @test_1[CoreAcquisitionData::ACQUIS_METHOD.name]).to be true
        expect(@search_results_page.row_exists? @test_1[CoreAcquisitionData::ACQUIS_REF_NUM.name]).to be true
        expect(@search_results_page.row_exists? @test_2[CoreAcquisitionData::ACQUIS_REF_NUM.name]).to be true
        expect(@search_results_page.row_exists? @test_3[CoreAcquisitionData::ACQUIS_REF_NUM.name]).to be false
      end
    end

    describe 'boolean field-based and keyword search' do

      before(:each) { (deploy == Deployment::PAHMA) ? @search_page.load_pahma_search_accessions_form : @search_page.load_search_acquisitions_form }

      it 'returns results matching any conditions' do
        @search_page.select_adv_search_any_option
        @search_page.enter_keyword @test_1[CoreAcquisitionData::ACQUIS_REASON.name]
        @search_page.enter_credit_line @test_1
        @search_page.select_acquisition_method @test_1
        @search_page.click_search_and_wait_for_results @search_results_page
        expect(@search_results_page.keyword_condition_present? @test_1[CoreAcquisitionData::ACQUIS_REASON.name]).to be true
        expect(@search_results_page.field_condition_present? @test_1[CoreAcquisitionData::CREDIT_LINE.name]).to be true
        expect(@search_results_page.field_condition_present? @test_1[CoreAcquisitionData::ACQUIS_METHOD.name]).to be true
        expect(@search_results_page.row_exists? @test_1[CoreAcquisitionData::ACQUIS_REF_NUM.name]).to be true
        expect(@search_results_page.row_exists? @test_2[CoreAcquisitionData::ACQUIS_REF_NUM.name]).to be true
        expect(@search_results_page.row_exists? @test_3[CoreAcquisitionData::ACQUIS_REF_NUM.name]).to be true
      end

      it 'returns results matching all conditions' do
        @search_page.select_adv_search_all_option
        @search_page.enter_keyword @test_1[CoreAcquisitionData::ACQUIS_REASON.name]
        @search_page.enter_credit_line @test_1
        @search_page.select_acquisition_method @test_1
        @search_page.click_search_and_wait_for_results @search_results_page
        expect(@search_results_page.keyword_condition_present? @test_1[CoreAcquisitionData::ACQUIS_REASON.name]).to be true
        expect(@search_results_page.field_condition_present? @test_1[CoreAcquisitionData::CREDIT_LINE.name]).to be true
        expect(@search_results_page.field_condition_present? @test_1[CoreAcquisitionData::ACQUIS_METHOD.name]).to be true
        expect(@search_results_page.row_exists? @test_1[CoreAcquisitionData::ACQUIS_REF_NUM.name]).to be true
        expect(@search_results_page.row_exists? @test_2[CoreAcquisitionData::ACQUIS_REF_NUM.name]).to be true
        expect(@search_results_page.row_exists? @test_3[CoreAcquisitionData::ACQUIS_REF_NUM.name]).to be false
      end

    end
  end
end
