require_relative '../spec_helper'

describe 'CollectionSpace' do

  include Logging
  include WebDriverManager

  before(:all) do
    @test = TestConfig.new Deployment::CORE
    @test.set_driver launch_browser
    @admin = @test.get_admin_user
    @login_page = LoginPage.new @test
    @create_new_page = CreateNewPage.new @test
    @search_page = SearchPage.new @test
    @search_results_page = SearchResultsPage.new @test
    @object_page = ObjectPage.new @test
    @acquisition_page = AcquisitionPage.new @test

    @login_page.load_page
    @login_page.log_in(@admin.username, @admin.password)

    @test_proc = {
      CoreAcquisitionData::ACQUIS_METHOD.name => 'gift',
      CoreAcquisitionData::ACCESSION_DATE_GRP.name => (Date.today - 1).to_s
    }
    @test.set_unique_test_id(@test_proc, CoreAcquisitionData::ACQUIS_REF_NUM.name)
    @search_page.click_create_new_link
    @create_new_page.click_create_new_acquisition
    @acquisition_page.create_new_acquisition @test_proc
    @core_id = "#{@test_proc[CoreAcquisitionData::ACQUIS_REF_NUM.name]}"
  end

  after(:all) { quit_browser @test.driver }

  all_secondary_tabs = ["Objects", "Acquisitions", "Condition Checks", "Conservation Treatments", \
    "Exhibitions", "Groups", "Intakes", "Loans In", "Loans Out", "Location/Movement/Inventory", \
    "Media Handling", "Object Exits", "Use of Collections", "Valuation Controls"]
  days = 1
  unsaved_message = "You're about to leave a record that has unsaved changes."

  context 'when navigating between tabs' do

    before(:all) {
      @search_page.quick_search("Acquisitions", [], @core_id)
      @search_results_page.click_result(0)
    }
    after(:all) {
      @acquisition_page.click_close_tab("Location/Movement/Inventory")
      @acquisition_page.click_close_tab("Exhibitions")
    }

    it "offers a Close button if unsaved changes" do
      @acquisition_page.enter_accession_date({CoreAcquisitionData::ACCESSION_DATE_GRP.name => (Date.today - days).to_s})
      @acquisition_page.select_related_type "Location/Movement/Inventory"
      expect(@acquisition_page.element_text(@acquisition_page.dialog_message)).to eql(unsaved_message)
      @acquisition_page.click_close_button
      expect(@acquisition_page.exists? @acquisition_page.dialog_message).to be false
    end

    it 'offers a Don\'t Leave button if unsaved changes' do
      @acquisition_page.select_related_type "Exhibitions"
      expect(@acquisition_page.element_text(@acquisition_page.dialog_message)).to eql(unsaved_message)
      @acquisition_page.do_not_leave_record
      expect(@acquisition_page.exists? @acquisition_page.dialog_message).to be false
    end

    it "offers a Revert and Continue button if unsaved changes and navigates to secondary tab" do
      @acquisition_page.click_movement_secondary_tab
      @acquisition_page.revert_and_continue
      expect(@acquisition_page.enabled? @acquisition_page.movement_secondary_tab).to be false
    end

    it "navigates back to primary tab reverted to original state" do
      @acquisition_page.click_primary_record_tab
      @acquisition_page.verify_accession_date @test_proc
    end

    it 'offers a Save and Continue button and navigates to secondary tab' do
      @test_proc[CoreAcquisitionData::ACCESSION_DATE_GRP.name] = (Date.today - days).to_s
      @acquisition_page.enter_accession_date(@test_proc)
      @acquisition_page.click_exhibitions_tab
      expect(@acquisition_page.element_text(@acquisition_page.dialog_message)).to eql(unsaved_message)
      @acquisition_page.save_and_continue
      expect(@acquisition_page.enabled? @acquisition_page.exhibition_tab).to be false
    end

    it 'navigates back to primary tab reflecting new changes' do
      @acquisition_page.click_primary_record_tab
      @acquisition_page.verify_accession_date @test_proc
    end
  end

  all_secondary_tabs.each do |tab|
    context "when navigating between Primary Tab and \"#{tab}\" Secondary Tab" do

      it 'offers a Close button if unsaved changes' do
        days += 1
        @acquisition_page.quick_search("Acquisitions", [], @core_id)
        @search_results_page.click_result(0)
        @acquisition_page.enter_accession_date({CoreAcquisitionData::ACCESSION_DATE_GRP.name => (Date.today - days).to_s})
        @acquisition_page.select_related_type tab
        expect(@acquisition_page.element_text(@acquisition_page.dialog_message)).to eql(unsaved_message)
        @acquisition_page.click_close_button
        expect(@acquisition_page.exists? @acquisition_page.dialog_message).to be false
        @acquisition_page.click_close_tab tab
      end

      it 'offers a Don\'t Leave button if unsaved changes' do
        @acquisition_page.select_related_type tab
        expect(@acquisition_page.element_text(@acquisition_page.dialog_message)).to eql(unsaved_message)
        @acquisition_page.do_not_leave_record
        expect(@acquisition_page.exists? @acquisition_page.dialog_message).to be false
        @acquisition_page.click_close_tab tab
      end

      it "offers a Revert and Continue button if unsaved changes and navigates to #{tab} tab" do
        @acquisition_page.select_related_type tab
        @acquisition_page.revert_and_continue
        expect(@acquisition_page.enabled?(@acquisition_page.related_type_tab(tab))).to be false
      end

      it "navigates back to primary tab reverted to original state" do
        @acquisition_page.click_primary_record_tab
        @acquisition_page.verify_accession_date @test_proc
      end

      it "offers a Save and Continue button and navigates to #{tab} tab" do
        @test_proc[CoreAcquisitionData::ACCESSION_DATE_GRP.name] = (Date.today - days).to_s
        @acquisition_page.enter_accession_date(@test_proc)
        @acquisition_page.click_related_tab tab
        expect(@acquisition_page.element_text(@acquisition_page.dialog_message)).to eql(unsaved_message)
        @acquisition_page.save_and_continue
        expect(@acquisition_page.enabled?( @acquisition_page.related_type_tab(tab))).to be false
      end

      it 'navigates back to primary tab reflecting new changes' do
        @acquisition_page.click_primary_record_tab
        @acquisition_page.verify_accession_date @test_proc
        @acquisition_page.click_close_tab tab
      end
    end
  end

end
