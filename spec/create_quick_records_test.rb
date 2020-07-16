require_relative '../spec_helper'
expectedURL = "https://core-dev.cspace.berkeley.edu/cspace/core/create"
describe 'CollectionSpace' do

  include Logging
  include WebDriverManager

  test_run = TestConfig.new

  before(:all) do
    test_run = TestConfig.new
    test_run.set_driver launch_browser
    @admin = test_run.get_admin_user
    @login_page = test_run.get_page CoreLoginPage
    @search_page = test_run.get_page CoreSearchPage
    @login_page.load_page
    @create_new_page = test_run.get_page CoreCreateNewPage
    @login_page.log_in(@admin.username, @admin.password)
    @object_page = test_run.get_page CoreObjectPage
    @condition_check_page = test_run.get_page CoreConditionCheckPage
    @acquisition_page = test_run.get_page CoreAcquisitionPage
    @conservation_page = test_run.get_page CoreConservationPage
    @exhibition_page = test_run.get_page CoreExhibitionPage
    @group_page = test_run.get_page CoreGroupPage
    @intake_page = test_run.get_page CoreIntakePage
    @loanin_page = test_run.get_page CoreLoanInPage
    @loanout_page = test_run.get_page CoreLoanOutPage
    @movement_page = test_run.get_page CoreInventoryMovementPage
    @media_handling_page = test_run.get_page CoreMediaHandlingPage
    @object_exit_page = test_run.get_page CoreObjectExitPage
    @uoc_page = test_run.get_page CoreUseOfCollectionsPage
    @valuation_page = test_run.get_page CoreValuationPage
    @organization_page = test_run.get_page CoreOrganizationPage
    @citation_page = test_run.get_page CoreCitationPage
    @concept_page = test_run.get_page CoreConceptPage
    @person_page = test_run.get_page CorePersonPage
    @place_page = test_run.get_page CorePlacePage
    @storage_page = test_run.get_page CoreStoragePage
    @work_page = test_run.get_page CoreWorkPage

  end
# This test does NOT check if the data entry form is empty
  after(:all) { quit_browser test_run.driver }

    it('Creates new page') {
      @search_page.click_create_new_link
      @create_new_page.click_create_new_link
    }
    it('Checks if new page url is correct') {
      if expectedURL == test_run.driver.current_url
      end
    }
    it('Goes to object tab and goes back to create new menu') {
      @create_new_page.click_create_new_object
      if 'https://core-dev.cspace.berkeley.edu/cspace/core/record/collectionobject' == test_run.driver.current_url
        @object_page.go_back
      end
    }
    it('Goes to aquisition tab and goes back to create new menu') {
      @create_new_page.click_create_new_acquisition
      if 'https://core-dev.cspace.berkeley.edu/cspace/core/record/acquisition' == test_run.driver.current_url
        @acquisition_page.go_back
      end
    }
    it('Goes to condition check tab and goes back to create new menu') {
      @create_new_page.click_create_new_condition_check
      if 'https://core-dev.cspace.berkeley.edu/cspace/core/record/conditioncheck' == test_run.driver.current_url
        @condition_check_page.go_back
      end
    }
    it('Goes to conversation tab and goes back to create new menu') {
      @create_new_page.click_create_new_conservation_check
      if ('https://core-dev.cspace.berkeley.edu/cspace/core/record/conservation' == test_run.driver.current_url)
        @conservation_page.go_back
      end
    }
    it('Goes to exhibition tab and goes back to create new menu') {
      @create_new_page.click_create_new_exhibition
      if ('https://core-dev.cspace.berkeley.edu/cspace/core/record/exhibition' == test_run.driver.current_url)
        @exhibition_page.go_back
      end
    }
    it('Goes to group tab and goes back to create new menu') {
      @create_new_page.click_create_new_group
      if('https://core-dev.cspace.berkeley.edu/cspace/core/record/group' == test_run.driver.current_url)
        @group_page.go_back
      end
    }
    it('Goes to intake tab and goes back to create new menu') {
      @create_new_page.click_create_new_intake
      if('https://core-dev.cspace.berkeley.edu/cspace/core/record/intake' == test_run.driver.current_url)
        @intake_page.go_back
      end
    }
    it('Goes to loan in tab and goes back to create new menu') {
      @create_new_page.click_create_new_loan_in
      if 'https://core-dev.cspace.berkeley.edu/cspace/core/record/loanin' == test_run.driver.current_url
        @loanin_page.go_back
      end
    }
    it('Goes to loan out tab and goes back to create new menu') {
      @create_new_page.click_create_new_loan_out
      if 'https://core-dev.cspace.berkeley.edu/cspace/core/record/loanout' == test_run.driver.current_url
        @loanout_page.go_back
      end
    }
    it('Goes to movement/inventory tab and goes back to create new menu') {
      @create_new_page.click_create_new_movement
      if 'https://core-dev.cspace.berkeley.edu/cspace/core/record/movement' == test_run.driver.current_url
        @movement_page.go_back
      end
    }
    it('Goes to media handling tab and goes back to create new menu') {
      @create_new_page.click_create_new_media_handling
      if 'https://core-dev.cspace.berkeley.edu/cspace/core/record/media' == test_run.driver.current_url
        @media_handling_page.go_back
      end
    }
    it('Goes to object exit tab and goes back to create new menu') {
      @create_new_page.click_create_new_object_exit
      if 'https://core-dev.cspace.berkeley.edu/cspace/core/record/objectexit' == test_run.driver.current_url
        @object_exit_page.go_back
      end
    }
    it('Goes to use of collections tab and goes back to create new menu') {
      @create_new_page.click_create_new_use_of_collections
      if('https://core-dev.cspace.berkeley.edu/cspace/core/record/uoc') == test_run.driver.current_url
        @uoc_page.go_back
      end
    }
    it('Goes to valuation tab and goes back to create new menu') {
      @create_new_page.click_create_new_valuation_control
      if('https://core-dev.cspace.berkeley.edu/cspace/core/record/valuation') == test_run.driver.current_url
        @valuation_page.go_back
      end
    }
    it('Goes to local citation tab and goes back to create new menu') {
      @create_new_page.click_create_new_authority_citation_local
      if('https://core-dev.cspace.berkeley.edu/cspace/core/record/citation/local') == test_run.driver.current_url
        @citation_page.go_back
      end
    }
    it('Goes to worldcat citation tab and goes back to create new menu') {
      @create_new_page.click_create_new_authority_citation_world
      if('https://core-dev.cspace.berkeley.edu/cspace/core/record/citation/worldcat') == test_run.driver.current_url
        @citation_page.go_back
      end
    }
    it('Goes to Activity concept tab and goes back to create new menu') {
      @create_new_page.click_create_new_authority_activity
      if('https://core-dev.cspace.berkeley.edu/cspace/core/record/concept/activity') == test_run.driver.current_url
        @concept_page.go_back
      end
    }
    it('Goes to associated concept tab and goes back to create new menu') {
      @create_new_page.click_create_new_authority_concept_associated
      if('https://core-dev.cspace.berkeley.edu/cspace/core/record/concept/associated') == test_run.driver.current_url
        @concept_page.go_back
      end
    }
    it('Goes to material concept tab and goes back to create new menu') {
      @create_new_page.click_create_new_authority_concept_material
      if('https://core-dev.cspace.berkeley.edu/cspace/core/record/concept/material') == test_run.driver.current_url
        @concept_page.go_back
      end
    }
    it('Goes to nomenclature concept tab and goes back to create new menu') {
      @create_new_page.click_create_new_authority_concept_nomenclature
      if('https://core-dev.cspace.berkeley.edu/cspace/core/record/concept/nomenclature') == test_run.driver.current_url
        @concept_page.go_back
      end
    }
    it('Goes to occasion concept tab and goes back to create new menu') {
      @create_new_page.click_create_new_authority_concept_occasion
      if('https://core-dev.cspace.berkeley.edu/cspace/core/record/concept/occasion') == test_run.driver.current_url
        @concept_page.go_back
      end
    }
    it('Goes to local organization tab and goes back to create new menu') {
      @create_new_page.click_create_new_org_local
      if('https://core-dev.cspace.berkeley.edu/cspace/core/record/organization/local') == test_run.driver.current_url
        @organization_page.go_back
      end
    }
    it('Goes to ULAN organization tab and goes back to create new menu') {
      @create_new_page.click_create_new_org_ulan
      if('https://core-dev.cspace.berkeley.edu/cspace/core/record/organization/ulan') == test_run.driver.current_url
        @organization_page.go_back
      end
    }
    it('Goes to local person tab and goes back to create new menu') {
      @create_new_page.click_create_new_authority_person_local
      if('https://core-dev.cspace.berkeley.edu/cspace/core/record/person/local') == test_run.driver.current_url
        @person_page.go_back
      end
    }
    it('Goes to ulan person tab and goes back to create new menu') {
      @create_new_page.click_create_new_authority_person_ulan
      if('https://core-dev.cspace.berkeley.edu/cspace/core/record/person/ulan') == test_run.driver.current_url
        @person_page.go_back
      end
    }
    it('Goes to local place tab and goes back to create new menu') {
      @create_new_page.click_create_new_place_local
      if('https://core-dev.cspace.berkeley.edu/cspace/core/record/place/local') == test_run.driver.current_url
        @place_page.go_back
      end
    }
    it('Goes to tgn place tab and goes back to create new menu') {
      @create_new_page.click_create_new_authority_place_tgn
      if('https://core-dev.cspace.berkeley.edu/cspace/core/record/place/tgn') == test_run.driver.current_url
        @place_page.go_back
      end
    }
    it('Goes to local storage tab and goes back to create new menu') {
      @create_new_page.click_create_new_authority_storage_local
      if('https://core-dev.cspace.berkeley.edu/cspace/core/record/location/local') == test_run.driver.current_url
        @storage_page.go_back
      end
    }
    it('Goes to offsite storage tab and goes back to create new menu') {
      @create_new_page.click_create_new_authority_storage_offsite
      if('https://core-dev.cspace.berkeley.edu/cspace/core/record/location/offsite') == test_run.driver.current_url
        @storage_page.go_back
      end
    }
    it('Goes to local work tab and goes back to create new menu') {
      @create_new_page.click_create_new_authority_work_local
      if('https://core-dev.cspace.berkeley.edu/cspace/core/record/work/local') == test_run.driver.current_url
        @work_page.go_back
      end
    }
    it('Goes to cona work tab and goes back to create new menu') {
      @create_new_page.click_create_new_authority_work_cona
      if('https://core-dev.cspace.berkeley.edu/cspace/core/record/work/cona') == test_run.driver.current_url
        @work_page.go_back
      end
    }
    end
    
