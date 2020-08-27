require_relative '../spec_helper'


test_run = TestConfig.new
test_data = test_run.create_data_entry_templates_test_data
index = 0;
pages = []
temp_pages = []
creates = []
ids = [
  CoreObjectData::OBJECT_NUM.name,
  CoreAcquisitionData::ACQUIS_REF_NUM.name,
  CoreConditionCheckData::COND_REF_NUM.name,
  CoreConservationData::CONSERV_NUM.name,
  CoreExhibitionData::EXHIBITION_NUM.name,
  CoreGroupData::TITLE.name,
  CoreIntakeData::ENTRY_NUMBER.name,
  CoreInventoryMovementData::REF_NUM.name,
  CoreLoanInData::LOAN_IN_NUM.name,
  CoreLoanOutData::LOAN_OUT_NUM.name,
  CoreMediaHandlingData::ID_NUM.name,
  CoreObjectExitData::EXIT_NUM.name,
  CoreUseOfCollectionsData::REFERENCE_NBR.name,
  CoreValuationControlData::VALUE_NUM.name,
  CoreAuthorityData::TERM_DISPLAY_NAME.name,
  CoreAuthorityData::TERM_DISPLAY_NAME.name,
  CoreAuthorityData::TERM_DISPLAY_NAME.name,
  CoreAuthorityData::TERM_DISPLAY_NAME.name,
  CoreAuthorityData::TERM_DISPLAY_NAME.name,
  CoreAuthorityData::TERM_DISPLAY_NAME.name,
  CoreAuthorityData::TERM_DISPLAY_NAME.name,
  CoreAuthorityData::TERM_DISPLAY_NAME.name,
  CoreAuthorityData::TERM_DISPLAY_NAME.name,
  CoreAuthorityData::TERM_DISPLAY_NAME.name,
  CoreAuthorityData::TERM_DISPLAY_NAME.name,
  CoreAuthorityData::TERM_DISPLAY_NAME.name,
  CoreAuthorityData::TERM_DISPLAY_NAME.name,
  CoreAuthorityData::TERM_DISPLAY_NAME.name,
  CoreAuthorityData::TERM_DISPLAY_NAME.name,
  CoreAuthorityData::TERM_DISPLAY_NAME.name,
  CoreAuthorityData::TERM_DISPLAY_NAME.name
]
templates = ['Inventory Template',  'Photograph Template', 'Doorstep Donation Template']
dex = [0, 1, 2]

describe 'CollectionSpace' do

  include Logging
  include WebDriverManager
  include Page 
  include CollectionSpacePages


  before(:all) do
    test_run = TestConfig.new
    test_run.set_driver launch_browser
    @admin = test_run.get_admin_user
    @login_page = test_run.get_page CoreLoginPage
    @search_page = test_run.get_page CoreSearchPage
    @result_page = test_run.get_page CoreSearchResultsPage
    @create_new_page = test_run.get_page CoreCreateNewPage

    @object_page = test_run.get_page CoreObjectPage

    @acquisition_page = test_run.get_page CoreAcquisitionPage
    @condition_page = test_run.get_page CoreConditionCheckPage
    @conservation_page = test_run.get_page CoreConservationPage
    @exhibition_page = test_run.get_page CoreExhibitionPage
    @group_page = test_run.get_page CoreGroupPage
    @intake_page = test_run.get_page CoreIntakePage
    @inventory_page = test_run.get_page CoreInventoryMovementPage
    @loan_in_page = test_run.get_page CoreLoanInPage
    @loan_out_page = test_run.get_page CoreLoanOutPage
    @media_page = test_run.get_page CoreMediaHandlingPage
    @object_exit_page = test_run.get_page CoreObjectExitPage
    @collections_page = test_run.get_page CoreUseOfCollectionsPage
    @valuation_page = test_run.get_page CoreValuationPage

    @auth_page = test_run.get_page CoreAuthorityPage
    @citation_page = test_run.get_page CoreCitationPage
    @concept_page = test_run.get_page CoreConceptPage
    @org_page = test_run.get_page CoreOrganizationPage
    @person_page = test_run.get_page CorePersonPage
    @place_page = test_run.get_page CorePlacePage
    @storage_page = test_run.get_page CoreStoragePage
    @work_page = test_run.get_page CoreWorkPage

    @login_page.load_page
    @login_page.log_in(@admin.username, @admin.password)

    pages = [
      @object_page,
      @acquisition_page,
      @condition_page,
      @conservation_page,
      @exhibition_page,
      @group_page,
      @intake_page,
      @inventory_page,
      @loan_in_page,
      @loan_out_page,
      @media_page,
      @object_exit_page,
      @collections_page,
      @valuation_page,
      @auth_page,
      @auth_page,
      @auth_page,
      @auth_page,
      @auth_page,
      @auth_page,
      @auth_page,
      @auth_page,
      @auth_page,
      @auth_page,
      @auth_page,
      @auth_page,
      @auth_page,
      @auth_page,
      @auth_page,
      @auth_page,
      @auth_page
    ]

    temp_pages = [@object_page, @object_page , @intake_page]

    def new_object; @create_new_page.click_create_new_object end
    def new_acquisition; @create_new_page.click_create_new_acquisition end
    def new_condition; @create_new_page.click_create_new_condition_check end
    def new_conservation; @create_new_page.click_create_new_conservation end
    def new_exhibition; @create_new_page.click_create_new_exhibition end
    def new_group; @create_new_page.click_create_new_group end
    def new_intake; @create_new_page.click_create_new_intake end
    def new_inventory; @create_new_page.click_create_new_movement end
    def new_loan_in; @create_new_page.click_create_new_loan_in end
    def new_loan_out; @create_new_page.click_create_new_loan_out end
    def new_media; @create_new_page.click_create_new_media_handling end
    def new_object_exit; @create_new_page.click_create_new_object_exit end
    def new_collections; @create_new_page.click_create_new_use_of_collections end
    def new_valuation; @create_new_page.click_create_new_valuation_control end
    def new_auth_1; @create_new_page.click_create_new_authority_citation_local end
    def new_auth_2; @create_new_page.click_create_new_authority_citation_world end
    def new_auth_3; @create_new_page.click_create_new_authority_concept_activity end
    def new_auth_4; @create_new_page.click_create_new_authority_concept_associated end
    def new_auth_5; @create_new_page.click_create_new_authority_concept_material end
    def new_auth_6; @create_new_page.click_create_new_authority_concept_nomenclature end
    def new_auth_7; @create_new_page.click_create_new_authority_concept_occasion end
    def new_auth_8; @create_new_page.click_create_new_org_local end
    def new_auth_9; @create_new_page.click_create_new_org_ulan end
    def new_auth_10; @create_new_page.click_create_new_authority_person_local end
    def new_auth_11; @create_new_page.click_create_new_authority_person_ulan end
    def new_auth_12; @create_new_page.click_create_new_authority_place_local end
    def new_auth_13; @create_new_page.click_create_new_authority_place_tgn end
    def new_auth_14; @create_new_page.click_create_new_authority_storage_local end
    def new_auth_15; @create_new_page.click_create_new_authority_storage_offsite end
    def new_auth_16; @create_new_page.click_create_new_authority_work_local end
    def new_auth_17; @create_new_page.click_create_new_authority_work_cona end
    creates = {
      0 => method(:new_object),
      1 => method(:new_acquisition),
      2 => method(:new_condition),
      3 => method(:new_conservation),
      4 => method(:new_exhibition),
      5 => method(:new_group),
      6 => method(:new_intake),
      7 => method(:new_inventory),
      8 => method(:new_loan_in),
      9 => method(:new_loan_out),
      10 => method(:new_media),
      11 => method(:new_object_exit),
      12 => method(:new_collections),
      13 => method(:new_valuation),
      14 => method(:new_auth_1),
      15 => method(:new_auth_2),
      16 => method(:new_auth_3),
      17 => method(:new_auth_4),
      18 => method(:new_auth_5),
      19 => method(:new_auth_6),
      20 => method(:new_auth_7),
      21 => method(:new_auth_8),
      22 => method(:new_auth_9),
      23 => method(:new_auth_10),
      24 => method(:new_auth_11),
      25 => method(:new_auth_12),
      26 => method(:new_auth_13),
      27 => method(:new_auth_14),
      28 => method(:new_auth_15),
      29 => method(:new_auth_16),
      30 => method(:new_auth_17)
    } 
  end

    after(:all) { quit_browser test_run.driver }
    # test 1
    test_data.each do |test|
        it "create new record with #{test}" do
            @search_page.click_create_new_link
            creates[index].()
            id1 = Time.now.to_i
            test.merge!({ids[index] => id1})
            data_input_errors = pages[index].enter_number_and_text test if (index != 14 && index != 15)
            data_input_errors = pages[index].enter_number_and_title test if (index == 14 || index == 15)
            Config.click_wait
            pages[index].hit_tab
            begin
              pages[index].click_clone_button
            rescue
              print('ok')
            end

            begin
              pages[index].click_save_button if index != 7
              pages[index].click_clone_button
            rescue
              print("bad0") if index != 7
            end
            pages[index].scroll_to_top
            dup = {}
            id2 = Time.now.to_i
            dup.merge!({ids[index] => id2})
            data_input_errors = pages[index].enter_number dup if index != 7
            data_input_errors = pages[index].enter_number test if index == 7
            pages[index].hit_tab
            begin
              pages[index].click_save_button if index != 7
            rescue
              print("bad1")
            end
            pages[index].click_search_link
            @search_page.select_record_type_option("All Records")
            @search_page.full_text_search("duplicate")
            begin
              @result_page.wait_for_results
            rescue  
              print("bad2")
            end
            begin
              @result_page.click_result(id1) if index != 7
              @result_page.click_result('sean test') if index == 7
              @result_page.delete_record
              @result_page.click_result(id2) if index != 7
              @result_page.click_result('sean test') if index == 7
              @result_page.delete_record
            rescue
              print("bad3")
            end
            print(index)
            index += 1
        end
    end



    def obj_0; {:xpath => '//span[contains(.,"Object Identification Information")]'} end
    def obj_1; {:xpath => '//span[contains(.,"Object Description Information")]'} end
    def obj_2; {:xpath => '//span[contains(.,"Object Production Information")]'} end
    def obj_3; {:xpath => '//span[contains(.,"Hierarchy")]'} end
    def obj_4; {:xpath => '//span[contains(.,"Reference Information")]'} end 
    def intake_0; {:xpath => '//span[contains(.,"Object Entry Information")]'} end
    def intake_1; {:xpath => '//span[contains(.,"Location Information")]'} end
    def intake_2; {:xpath => '//span[contains(.,"Condition Check Information")]'} end 
    # test 2
    dex.each do |i|
      it "changes object template" do
        @search_page.click_create_new_link
        @create_new_page.click_create_new_object if i != 2
        @create_new_page.click_create_new_intake if i == 2
        temp_pages[i].select_template(templates[i]) 
        expect(temp_pages[i].exists? obj_0).to be true if i != 2
        expect(temp_pages[i].exists? obj_1).to be true if i != 2
        expect(temp_pages[i].exists? obj_2).to be true if i != 2
        expect(temp_pages[i].exists? obj_3).to be true if i != 2
        expect(temp_pages[i].exists? obj_4).to be true if i == 1
        expect(temp_pages[i].exists? intake_0).to be true if i == 2
        expect(temp_pages[i].exists? intake_1).to be true if i == 2
        expect(temp_pages[i].exists? intake_2).to be true if i == 2
        temp = {}
        id = Time.now.to_i
        temp.merge!({CoreObjectData::OBJECT_NUM.name => id}) if i != 2
        temp.merge!({CoreIntakeData::ENTRY_NUMBER.name => id}) if i == 2
        data_input_errors = temp_pages[i].enter_number temp
        temp_pages[i].click_save_button
        temp_pages[i].click_search_link
        @search_page.select_record_type_option("All Records")
        @search_page.full_text_search(id)
        @result_page.wait_for_results
        @result_page.click_result(id)
        @result_page.click_clone_button 
        data_input_errors = temp_pages[i].enter_number temp
        temp_pages[i].click_save_button
        temp_pages[i].select_template('Standard Template')
        @result_page.delete_record
        @search_page.select_record_type_option("All Records")
        @search_page.full_text_search(id)
        @result_page.wait_for_results
        @result_page.click_result(id)
        @result_page.delete_record
        print(i)
      end
    end

    # test 3
    it "Keyboard Navigation" do
      @search_page.click_create_new_link
      @create_new_page.click_create_new_object
      temp = {}
      id = Time.now.to_i
      temp.merge!({CoreObjectData::OBJECT_NUM.name => id})
      data_input_errors = @object_page.enter_number temp
      @object_page.click_save_button
      # tab is 2 less than manually tested on website
      for i in 0..54
        @object_page.hit_tab
      end
      @object_page.hit_enter
      @object_page.click_search_link
      @search_page.full_text_search(id)
      @result_page.wait_for_results
      @result_page.click_result(id)
      @result_page.click_save_button
      @result_page.hit_tab
      for i in 0..1
        @result_page.hit_down_arrow
        @result_page.hit_down_arrow
        @result_page.hit_enter
      end
      @result_page.delete_record
      @search_page.click_create_new_link
    end
end
