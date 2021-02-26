require_relative '../spec_helper'
expectedURL = "https://core-dev.cspace.berkeley.edu/cspace/core/create"
describe 'CollectionSpace' do

  include Logging
  include WebDriverManager

  before(:all) do
    @test = TestConfig.new Deployment::CORE_UCB
    @test.set_driver launch_browser
    @admin = @test.get_admin_user
    @login_page = LoginPage.new @test
    @search_page = SearchPage.new @test
    @create_new_page = CreateNewPage.new @test
    @object_page = ObjectPage.new @test
    @condition_check_page = ConditionCheckPage.new @test
    @acquisition_page = AcquisitionPage.new @test
    @conservation_page = ConservationPage.new @test
    @exhibition_page = ExhibitionPage.new @test
    @group_page = GroupPage.new @test
    @intake_page = IntakePage.new @test
    @loanin_page = LoanInPage.new @test
    @loanout_page = LoanOutPage.new @test
    @movement_page = InventoryMovementPage.new @test
    @media_handling_page = MediaHandlingPage.new @test
    @object_exit_page = ObjectExitPage.new @test
    @uoc_page = UseOfCollectionsPage.new @test
    @valuation_page = ValuationControlPage.new @test
    @organization_page = OrganizationPage.new @test
    @citation_page = CitationPage.new @test
    @concept_page = ConceptPage.new @test
    @person_page = PersonPage.new @test
    @place_page = PlacePage.new @test
    @storage_page = StoragePage.new @test
    @work_page = WorkPage.new @test

    @login_page.load_page
    @login_page.log_in(@admin.username, @admin.password)
  end
# This test does NOT check if the data entry form is empty
  after(:all) { quit_browser @test.driver }

    it('Creates new page') {
      @search_page.click_create_new_link
      @create_new_page.click_create_new_link
    }
    it('Checks if new page url is correct') {
      if expectedURL == @test.driver.current_url
      end
    }
    it('Goes to object tab and goes back to create new menu') {
      @create_new_page.click_create_new_object
      if 'https://core-dev.cspace.berkeley.edu/cspace/core/record/collectionobject' == @test.driver.current_url
        @object_page.go_back
      end
    }
    it('Goes to aquisition tab and goes back to create new menu') {
      @create_new_page.click_create_new_acquisition
      if 'https://core-dev.cspace.berkeley.edu/cspace/core/record/acquisition' == @test.driver.current_url
        @acquisition_page.go_back
      end
    }
    it('Goes to condition check tab and goes back to create new menu') {
      @create_new_page.click_create_new_condition_check
      if 'https://core-dev.cspace.berkeley.edu/cspace/core/record/conditioncheck' == @test.driver.current_url
        @condition_check_page.go_back
      end
    }
    it('Goes to conversation tab and goes back to create new menu') {
      @create_new_page.click_create_new_conservation
      if ('https://core-dev.cspace.berkeley.edu/cspace/core/record/conservation' == @test.driver.current_url)
        @conservation_page.go_back
      end
    }
    it('Goes to exhibition tab and goes back to create new menu') {
      @create_new_page.click_create_new_exhibition
      if ('https://core-dev.cspace.berkeley.edu/cspace/core/record/exhibition' == @test.driver.current_url)
        @exhibition_page.go_back
      end
    }
    it('Goes to group tab and goes back to create new menu') {
      @create_new_page.click_create_new_group
      if('https://core-dev.cspace.berkeley.edu/cspace/core/record/group' == @test.driver.current_url)
        @group_page.go_back
      end
    }
    it('Goes to intake tab and goes back to create new menu') {
      @create_new_page.click_create_new_intake
      if('https://core-dev.cspace.berkeley.edu/cspace/core/record/intake' == @test.driver.current_url)
        @intake_page.go_back
      end
    }
    it('Goes to loan in tab and goes back to create new menu') {
      @create_new_page.click_create_new_loan_in
      if 'https://core-dev.cspace.berkeley.edu/cspace/core/record/loanin' == @test.driver.current_url
        @loanin_page.go_back
      end
    }
    it('Goes to loan out tab and goes back to create new menu') {
      @create_new_page.click_create_new_loan_out
      if 'https://core-dev.cspace.berkeley.edu/cspace/core/record/loanout' == @test.driver.current_url
        @loanout_page.go_back
      end
    }
    it('Goes to movement/inventory tab and goes back to create new menu') {
      @create_new_page.click_create_new_movement
      if 'https://core-dev.cspace.berkeley.edu/cspace/core/record/movement' == @test.driver.current_url
        @movement_page.go_back
      end
    }
    it('Goes to media handling tab and goes back to create new menu') {
      @create_new_page.click_create_new_media_handling
      if 'https://core-dev.cspace.berkeley.edu/cspace/core/record/media' == @test.driver.current_url
        @media_handling_page.go_back
      end
    }
    it('Goes to object exit tab and goes back to create new menu') {
      @create_new_page.click_create_new_object_exit
      if 'https://core-dev.cspace.berkeley.edu/cspace/core/record/objectexit' == @test.driver.current_url
        @object_exit_page.go_back
      end
    }
    it('Goes to use of collections tab and goes back to create new menu') {
      @create_new_page.click_create_new_use_of_collections
      if('https://core-dev.cspace.berkeley.edu/cspace/core/record/uoc') == @test.driver.current_url
        @uoc_page.go_back
      end
    }
    it('Goes to valuation tab and goes back to create new menu') {
      @create_new_page.click_create_new_valuation_control
      if('https://core-dev.cspace.berkeley.edu/cspace/core/record/valuation') == @test.driver.current_url
        @valuation_page.go_back
      end
    }
    it('Goes to local citation tab and goes back to create new menu') {
      @create_new_page.click_create_new_authority_citation_local
      if('https://core-dev.cspace.berkeley.edu/cspace/core/record/citation/local') == @test.driver.current_url
        @citation_page.go_back
      end
    }
    it('Goes to worldcat citation tab and goes back to create new menu') {
      @create_new_page.click_create_new_authority_citation_world
      if('https://core-dev.cspace.berkeley.edu/cspace/core/record/citation/worldcat') == @test.driver.current_url
        @citation_page.go_back
      end
    }
    it('Goes to Activity concept tab and goes back to create new menu') {
      @create_new_page.click_create_new_authority_concept_activity
      if('https://core-dev.cspace.berkeley.edu/cspace/core/record/concept/activity') == @test.driver.current_url
        @concept_page.go_back
      end
    }
    it('Goes to associated concept tab and goes back to create new menu') {
      @create_new_page.click_create_new_authority_concept_associated
      if('https://core-dev.cspace.berkeley.edu/cspace/core/record/concept/associated') == @test.driver.current_url
        @concept_page.go_back
      end
    }
    it('Goes to material concept tab and goes back to create new menu') {
      @create_new_page.click_create_new_authority_concept_material
      if('https://core-dev.cspace.berkeley.edu/cspace/core/record/concept/material') == @test.driver.current_url
        @concept_page.go_back
      end
    }
    it('Goes to nomenclature concept tab and goes back to create new menu') {
      @create_new_page.click_create_new_authority_concept_nomenclature
      if('https://core-dev.cspace.berkeley.edu/cspace/core/record/concept/nomenclature') == @test.driver.current_url
        @concept_page.go_back
      end
    }
    it('Goes to occasion concept tab and goes back to create new menu') {
      @create_new_page.click_create_new_authority_concept_occasion
      if('https://core-dev.cspace.berkeley.edu/cspace/core/record/concept/occasion') == @test.driver.current_url
        @concept_page.go_back
      end
    }
    it('Goes to local organization tab and goes back to create new menu') {
      @create_new_page.click_create_new_org_local
      if('https://core-dev.cspace.berkeley.edu/cspace/core/record/organization/local') == @test.driver.current_url
        @organization_page.go_back
      end
    }
    it('Goes to ULAN organization tab and goes back to create new menu') {
      @create_new_page.click_create_new_org_ulan
      if('https://core-dev.cspace.berkeley.edu/cspace/core/record/organization/ulan') == @test.driver.current_url
        @organization_page.go_back
      end
    }
    it('Goes to local person tab and goes back to create new menu') {
      @create_new_page.click_create_new_authority_person_local
      if('https://core-dev.cspace.berkeley.edu/cspace/core/record/person/local') == @test.driver.current_url
        @person_page.go_back
      end
    }
    it('Goes to ulan person tab and goes back to create new menu') {
      @create_new_page.click_create_new_authority_person_ulan
      if('https://core-dev.cspace.berkeley.edu/cspace/core/record/person/ulan') == @test.driver.current_url
        @person_page.go_back
      end
    }
    it('Goes to local place tab and goes back to create new menu') {
      @create_new_page.click_create_new_authority_place_local
      if('https://core-dev.cspace.berkeley.edu/cspace/core/record/place/local') == @test.driver.current_url
        @place_page.go_back
      end
    }
    it('Goes to tgn place tab and goes back to create new menu') {
      @create_new_page.click_create_new_authority_place_tgn
      if('https://core-dev.cspace.berkeley.edu/cspace/core/record/place/tgn') == @test.driver.current_url
        @place_page.go_back
      end
    }
    it('Goes to local storage tab and goes back to create new menu') {
      @create_new_page.click_create_new_authority_storage_local
      if('https://core-dev.cspace.berkeley.edu/cspace/core/record/location/local') == @test.driver.current_url
        @storage_page.go_back
      end
    }
    it('Goes to offsite storage tab and goes back to create new menu') {
      @create_new_page.click_create_new_authority_storage_offsite
      if('https://core-dev.cspace.berkeley.edu/cspace/core/record/location/offsite') == @test.driver.current_url
        @storage_page.go_back
      end
    }
    it('Goes to local work tab and goes back to create new menu') {
      @create_new_page.click_create_new_authority_work_local
      if('https://core-dev.cspace.berkeley.edu/cspace/core/record/work/local') == @test.driver.current_url
        @work_page.go_back
      end
    }
    it('Goes to cona work tab and goes back to create new menu') {
      @create_new_page.click_create_new_authority_work_cona
      if('https://core-dev.cspace.berkeley.edu/cspace/core/record/work/cona') == @test.driver.current_url
        @work_page.go_back
      end
    }
    end
    
