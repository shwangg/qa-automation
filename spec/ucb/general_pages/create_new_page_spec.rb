require_relative '../../../spec_helper'

describe 'CollectionSpace create new link' do

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
    @search_page.click_create_new_link
    @create_new_page.click_create_new_link
  end
  # This test does NOT check if the data entry form is empty
  after(:all) { quit_browser @test.driver }

  it('allows a user to create a new object') do
    start = @create_new_page.click_create_new_object
    @object_page.wait_for_title 'Object', start
  end
  it('allows a user to create a new acquisition') do
    @object_page.go_back
    start = @create_new_page.click_create_new_acquisition
    @acquisition_page.wait_for_title 'Acquisition', start
  end
  it('allows a user to create a new condition check') do
    @acquisition_page.go_back
    start = @create_new_page.click_create_new_condition_check
    @condition_check_page.wait_for_title 'Condition Check', start
  end
  it('allows a user to create a new conservation') do
    @condition_check_page.go_back
    start = @create_new_page.click_create_new_conservation
    @conservation_page.wait_for_title 'Conservation', start
  end
  it('allows a user to create a new exhibition') do
    @conservation_page.go_back
    start = @create_new_page.click_create_new_exhibition
    @exhibition_page.wait_for_title 'Exhibition', start
  end
  it('allows a user to create a new group') do
    @exhibition_page.go_back
    start = @create_new_page.click_create_new_group
    @group_page.wait_for_title 'Group', start
  end
  it('allows a user to create a new intake') do
    @group_page.go_back
    start = @create_new_page.click_create_new_intake
    @intake_page.wait_for_title 'Intake', start
  end
  it('allows a user to create a new loan in') do
    @intake_page.go_back
    start = @create_new_page.click_create_new_loan_in
    @loanin_page.wait_for_title 'Loan In', start
  end
  it('allows a user to create a new loan out') do
    @loanin_page.go_back
    start = @create_new_page.click_create_new_loan_out
    @loanout_page.wait_for_title 'Loan Out', start
  end
  it('allows a user to create a new location/movement/inventory') do
    @loanout_page.go_back
    start = @create_new_page.click_create_new_movement
    @movement_page.wait_for_title 'Location/Movement/Inventory', start
  end
  it('allows a user to create a new media handling') do
    @movement_page.go_back
    start = @create_new_page.click_create_new_media_handling
    @media_handling_page.wait_for_title 'Media Handling', start
  end
  it('allows a user to create a new object exit') do
    @media_handling_page.go_back
    start = @create_new_page.click_create_new_object_exit
    @object_exit_page.wait_for_title 'Object Exit', start
  end
  it('allows a user to create a new use of collections') do
    @object_exit_page.go_back
    start = @create_new_page.click_create_new_use_of_collections
    @uoc_page.wait_for_title 'Use of Collections', start
  end
  it('allows a user to create a new valuation') do
    @uoc_page.go_back
    start = @create_new_page.click_create_new_valuation_control
    @valuation_page.wait_for_title 'Valuation Control', start
  end
  it('allows a user to create a new local citation') do
    @valuation_page.go_back
    start = @create_new_page.click_create_new_authority_citation_local
    @citation_page.wait_for_title 'Citation - Local', start
  end
  it('allows a user to create a new worldcat citation') do
    @citation_page.go_back
    start = @create_new_page.click_create_new_authority_citation_world
    @citation_page.wait_for_title 'Citation - WorldCat', start
  end
  it('allows a user to create a new activity concept') do
    @citation_page.go_back
    start = @create_new_page.click_create_new_authority_concept_activity
    @concept_page.wait_for_title 'Concept - Activity', start
  end
  it('allows a user to create a new associated concept') do
    @concept_page.go_back
    start = @create_new_page.click_create_new_authority_concept_associated
    @concept_page.wait_for_title 'Concept - Associated', start
  end
  it('allows a user to create a new material concept') do
    @concept_page.go_back
    start = @create_new_page.click_create_new_authority_concept_material
    @concept_page.wait_for_title 'Concept - Material', start
  end
  it('allows a user to create a new nomenclature concept') do
    @concept_page.go_back
    start = @create_new_page.click_create_new_authority_concept_nomenclature
    @concept_page.wait_for_title 'Concept - Nomenclature', start
  end
  it('allows a user to create a new occasion concept') do
    @concept_page.go_back
    start = @create_new_page.click_create_new_authority_concept_occasion
    @concept_page.wait_for_title 'Concept - Occasion', start
  end
  it('allows a user to create a new local organization') do
    @concept_page.go_back
    start = @create_new_page.click_create_new_org_local
    @organization_page.wait_for_title 'Organization - Local', start
  end
  it('allows a user to create a new ULAN organization') do
    @organization_page.go_back
    start = @create_new_page.click_create_new_org_ulan
    @organization_page.wait_for_title 'Organization - ULAN', start
  end
  it('allows a user to create a new local person') do
    @organization_page.go_back
    start = @create_new_page.click_create_new_authority_person_local
    @person_page.wait_for_title 'Person - Local', start
  end
  it('allows a user to create a new ULAN person') do
    @person_page.go_back
    start = @create_new_page.click_create_new_authority_person_ulan
    @person_page.wait_for_title 'Person - ULAN', start
  end
  it('allows a user to create a new local place') do
    @person_page.go_back
    start = @create_new_page.click_create_new_authority_place_local
    @place_page.wait_for_title 'Place - Local', start
  end
  it('allows a user to create a new TGN place') do
    @place_page.go_back
    start = @create_new_page.click_create_new_authority_place_tgn
    @place_page.wait_for_title 'Place - TGN', start
  end
  it('allows a user to create a new local storage location') do
    @place_page.go_back
    start = @create_new_page.click_create_new_authority_storage_local
    @storage_page.wait_for_title 'Storage Location - Local', start
  end
  it('allows a user to create a new offsite storage location') do
    @storage_page.go_back
    start = @create_new_page.click_create_new_authority_storage_offsite
    @storage_page.wait_for_title 'Storage Location - Offsite', start
  end
  it('allows a user to create a new local work') do
    @storage_page.go_back
    start = @create_new_page.click_create_new_authority_work_local
    @work_page.wait_for_title 'Work - Local', start
  end
  it('allows a user to create a new CONA work') do
    @work_page.go_back
    start = @create_new_page.click_create_new_authority_work_cona
    @work_page.wait_for_title 'Work - CONA', start
  end
end

