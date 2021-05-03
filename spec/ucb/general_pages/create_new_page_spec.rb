require_relative '../../../spec_helper'

[Deployment::CORE_UCB, Deployment::PAHMA].each do |deploy|

  describe "#{deploy.name} CollectionSpace create new link" do

    include Logging
    include WebDriverManager

    before(:all) do
      @test = TestConfig.new deploy
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
      @nagpra_claim_page = NAGPRAClaimPage.new @test
      @object_exit_page = ObjectExitPage.new @test
      @osteology_page = OsteologyPage.new @test
      @uoc_page = UseOfCollectionsPage.new @test
      @valuation_page = ValuationControlPage.new @test
      @organization_page = OrganizationPage.new @test
      @citation_page = CitationPage.new @test
      @concept_page = ConceptPage.new @test
      @person_page = PersonPage.new @test
      @place_page = PlacePage.new @test
      @storage_page = StoragePage.new @test
      @taxon_page = TaxonPage.new @test
      @work_page = WorkPage.new @test

      @login_page.load_page
      @login_page.log_in(@admin.username, @admin.password)
      @search_page.click_create_new_link
      @create_new_page.click_create_new_link
    end
    # This test does NOT check if the data entry form is empty
    after(:all) { quit_browser @test.driver }

    it('offers a user a link to create a new object') do
      start = @create_new_page.click_create_new_object
      @object_page.wait_for_title 'Object', start
    end
    it('offers a user a link to create a new acquisition/accession') do
      @object_page.go_back
      start = @create_new_page.click_create_new_acquisition
      title = (deploy == Deployment::PAHMA) ? 'Accession' : 'Acquisition'
      @acquisition_page.wait_for_title title, start
    end
    it('offers a user a link to create a new condition check') do
      @acquisition_page.go_back
      start = @create_new_page.click_create_new_condition_check
      @condition_check_page.wait_for_title 'Condition Check', start
    end
    it('offers a user a link to create a new conservation') do
      @condition_check_page.go_back
      start = @create_new_page.click_create_new_conservation
      @conservation_page.wait_for_title 'Conservation', start
    end
    it('offers a user a link to create a new exhibition') do
      @conservation_page.go_back
      start = @create_new_page.click_create_new_exhibition
      @exhibition_page.wait_for_title 'Exhibition', start
    end
    it('offers a user a link to create a new group') do
      @exhibition_page.go_back
      start = @create_new_page.click_create_new_group
      @group_page.wait_for_title 'Group', start
    end
    it('offers a user a link to create a new intake') do
      @group_page.go_back
      start = @create_new_page.click_create_new_intake
      title = (deploy == Deployment::PAHMA) ? 'Object Entry' : 'Intake'
      @intake_page.wait_for_title title, start
    end
    it('offers a user a link to create a new loan in') do
      @intake_page.go_back
      start = @create_new_page.click_create_new_loan_in
      title = (deploy == Deployment::PAHMA) ? 'In Loan' : 'Loan In'
      @loanin_page.wait_for_title title, start
    end
    it('offers a user a link to create a new loan out') do
      @loanin_page.go_back
      start = @create_new_page.click_create_new_loan_out
      title = (deploy == Deployment::PAHMA) ? 'Out Loan' : 'Loan Out'
      @loanout_page.wait_for_title title, start
    end
    it('offers a user a link to create a new location/movement/inventory') do
      @loanout_page.go_back
      start = @create_new_page.click_create_new_movement
      title = (deploy == Deployment::PAHMA) ? 'Inventory/Movement' : 'Location/Movement/Inventory'
      @movement_page.wait_for_title title, start
    end
    it('offers a user a link to create a new media handling') do
      @movement_page.go_back
      start = @create_new_page.click_create_new_media_handling
      title = (deploy == Deployment::PAHMA) ? 'Media record | Media' : 'Media Handling'
      @media_handling_page.wait_for_title title, start
    end
    if deploy == Deployment::PAHMA
      it('offers a user a link to create a new NAGPRA claim') do
        @movement_page.go_back
        start = @create_new_page.click_create_new_nagpra_claim
        @nagpra_claim_page.wait_for_title 'NAGPRA Claim', start
      end
    end
    it('offers a user a link to create a new object exit') do
      @media_handling_page.go_back
      start = @create_new_page.click_create_new_object_exit
      @object_exit_page.wait_for_title 'Object Exit', start
    end
    if deploy == Deployment::PAHMA
      it('offers a user a link to create a new osteology') do
        @object_exit_page.go_back
        start = @create_new_page.click_create_new_osteology
        @osteology_page.wait_for_title 'Osteology', start
      end
    end
    it('offers a user a link to create a new use of collections') do
      @object_exit_page.go_back
      start = @create_new_page.click_create_new_use_of_collections
      @uoc_page.wait_for_title 'Use of Collections', start
    end
    it('offers a user a link to create a new valuation') do
      @uoc_page.go_back
      start = @create_new_page.click_create_new_valuation_control
      @valuation_page.wait_for_title 'Valuation Control', start
    end
    it('offers a user a link to create a new local citation') do
      @valuation_page.go_back
      start = @create_new_page.click_create_new_authority_citation_local
      @citation_page.wait_for_title 'Citation - Local', start
    end
    it('offers a user a link to create a new activity concept') do
      @citation_page.go_back
      start = @create_new_page.click_create_new_authority_concept_activity
      @concept_page.wait_for_title 'Concept - Activity', start
    end
    it('offers a user a link to create a new material concept') do
      @concept_page.go_back
      start = @create_new_page.click_create_new_authority_concept_material
      @concept_page.wait_for_title 'Concept - Material', start
    end
    it('offers a user a link to create a new occasion concept') do
      @concept_page.go_back
      start = @create_new_page.click_create_new_authority_concept_occasion
      @concept_page.wait_for_title 'Concept - Occasion', start
    end
    it('offers a user a link to create a new local organization') do
      @concept_page.go_back
      start = @create_new_page.click_create_new_org_local
      title = (deploy == Deployment::PAHMA) ? 'Organization - PAHMA' : 'Organization - Local'
      @organization_page.wait_for_title title, start
    end
    it('offers a user a link to create a new local person') do
      @organization_page.go_back
      start = @create_new_page.click_create_new_authority_person_local
      title = (deploy === Deployment::PAHMA) ? 'Person - PAHMA' : 'Person - Local'
      @person_page.wait_for_title title, start
    end
    it('offers a user a link to create a new local place') do
      @person_page.go_back
      start = @create_new_page.click_create_new_authority_place_local
      title = (deploy == Deployment::PAHMA) ? 'Place - PAHMA' : 'Place - Local'
      @place_page.wait_for_title title, start
    end
    it('offers a user a link to create a new local storage location') do
      @place_page.go_back
      start = @create_new_page.click_create_new_authority_storage_local
      title = (deploy == Deployment::PAHMA) ? 'Storage Location - PAHMA' : 'Storage Location - Local'
      @storage_page.wait_for_title title, start
    end
    it('offers a user a link to create a new local work') do
      @storage_page.go_back
      start = @create_new_page.click_create_new_authority_work_local
      @work_page.wait_for_title 'Work - Local', start
    end

    if deploy == Deployment::CORE_UCB
      it('offers a user a link to create a new worldcat citation') do
        @citation_page.go_back
        start = @create_new_page.click_create_new_authority_citation_world
        @citation_page.wait_for_title 'Citation - WorldCat', start
      end
      it('offers a user a link to create a new associated concept') do
        @concept_page.go_back
        start = @create_new_page.click_create_new_authority_concept_associated
        @concept_page.wait_for_title 'Concept - Associated', start
      end
      it('offers a user a link to create a new nomenclature concept') do
        @concept_page.go_back
        start = @create_new_page.click_create_new_authority_concept_nomenclature
        @concept_page.wait_for_title 'Concept - Nomenclature', start
      end
      it('offers a user a link to create a new ULAN organization') do
        @organization_page.go_back
        start = @create_new_page.click_create_new_org_ulan
        @organization_page.wait_for_title 'Organization - ULAN', start
      end
      it('offers a user a link to create a new ULAN person') do
        @person_page.go_back
        start = @create_new_page.click_create_new_authority_person_ulan
        @person_page.wait_for_title 'Person - ULAN', start
      end
      it('offers a user a link to create a new TGN place') do
        @place_page.go_back
        start = @create_new_page.click_create_new_authority_place_tgn
        @place_page.wait_for_title 'Place - TGN', start
      end
      it('offers a user a link to create a new offsite storage location') do
        @storage_page.go_back
        start = @create_new_page.click_create_new_authority_storage_offsite
        @storage_page.wait_for_title 'Storage Location - Offsite', start
      end
      it('offers a user a link to create a new CONA work') do
        @work_page.go_back
        start = @create_new_page.click_create_new_authority_work_cona
        @work_page.wait_for_title 'Work - CONA', start
      end
    end

    if deploy == Deployment::PAHMA
      it('offers a user a link to create a new archaeological culture concept') do
        @concept_page.go_back
        start = @create_new_page.click_create_new_authority_concept_arch_culture
        @concept_page.wait_for_title 'Concept - Archaeological Culture', start
      end
      it('offers a user a link to create a new ethnographic culture concept') do
        @concept_page.go_back
        start = @create_new_page.click_create_new_authority_concept_ethno_culture
        @concept_page.wait_for_title 'Concept - Ethnographic Culture', start
      end
      it('offers a user a link to create a new ethnographic file code concept') do
        @concept_page.go_back
        start = @create_new_page.click_create_new_authority_concept_ethno_file_code
        @concept_page.wait_for_title 'Concept - Ethnographic File Code', start
      end
      it('offers a user a link to create a new object class concept') do
        @concept_page.go_back
        start = @create_new_page.click_create_new_authority_concept_object_class
        @concept_page.wait_for_title 'Concept - Object Class', start
      end
      it('offers a user a link to create a new object name concept') do
        @concept_page.go_back
        start = @create_new_page.click_create_new_authority_concept_object_name
        @concept_page.wait_for_title 'Concept - Object Name', start
      end
      it('offers a user a link to create a new crate storage location') do
        @concept_page.go_back
        start = @create_new_page.click_create_new_authority_storage_crate
        @storage_page.wait_for_title 'Storage Location - Crate', start
      end
      it('offers a user a link to create a new taxon') do
        @storage_page.go_back
        start = @create_new_page.click_create_new_authority_taxon_default
        @taxon_page.wait_for_title 'Taxon - PAHMA', start
      end
    end
  end
end
