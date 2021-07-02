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
    @media_handling_page = MediaHandlingPage.new @test

    @login_page.load_page
    @login_page.log_in(@admin.username, @admin.password)
  end

  after(:all) { quit_browser @test.driver }

  obj_name, acq_name = Time.now.to_i, Time.now.to_i/5
  related_rec_1, related_rec_2 = 3 * Time.now.to_i, 6 * Time.now.to_i
  test_1_object = { CoreObjectData::OBJECT_NUM.name => obj_name }
  test_2_acquisition = { CoreAcquisitionData::ACQUIS_REF_NUM.name => acq_name }

  context "when searching related object records" do

    before(:all) {
      @search_page.click_create_new_link
      @create_new_page.click_create_new_object
      @object_page.create_new_object test_1_object
      @object_page.scroll_to_top
    }

    it 'displays an empty Related Objects menu if no results'do
      @object_page.click_open_related_object
      @search_results_page.when_exists(@search_results_page.no_terms_msg, Config.short_wait)
    end

    it 'displays related Object records as search results' do
      @object_page.wait_for_element_and_click(@search_results_page.title_bar_record_link(obj_name))
      @object_page.select_related_type("Objects")
      [related_rec_1, related_rec_2].each do |ref_num|
        @object_page.click_create_new_button
        @object_page.create_new_object({CoreObjectData::OBJECT_NUM.name => ref_num})
      end
      @object_page.click_open_related_object
      @object_page.refresh_page
      @search_results_page.wait_for_results
      expect(@object_page.exists?(@search_results_page.result_row(related_rec_1))).to be true
      expect(@object_page.exists?(@search_results_page.result_row(related_rec_2))).to be true
      expect(@object_page.element_text(@object_page.page_h1)).to eql("Objects related to #{obj_name}")
    end
  end

  context "when searching related procedural records" do

    before(:all) {
      @search_page.click_create_new_link
      @create_new_page.click_create_new_acquisition
      @acquisition_page.create_new_acquisition test_2_acquisition
      @acquisition_page.scroll_to_top
    }

    it 'displays an empty Related Procedures menu if no results' do
      @acquisition_page.click_open_related_procedures
      @search_results_page.when_exists(@search_results_page.no_results_msg, Config.short_wait)
    end

    it 'displays related Procedural records as search results' do
      @acquisition_page.wait_for_element_and_click(@search_results_page.title_bar_record_link(acq_name))
      @acquisition_page.select_related_type("Media Handling")
      [related_rec_1, related_rec_2].each do |ref_num|
        @media_handling_page.click_create_new_button
        @media_handling_page.create_new_media({CoreMediaHandlingData::ID_NUM.name => ref_num})
      end
      @acquisition_page.click_open_related_procedures
      @acquisition_page.refresh_page
      @search_results_page.wait_for_results
      expect(@acquisition_page.exists?(@search_results_page.result_row(related_rec_1))).to be true
      expect(@acquisition_page.exists?(@search_results_page.result_row(related_rec_2))).to be true
      expect(@acquisition_page.element_text(@acquisition_page.page_h1)).to eql("Procedures related to #{acq_name}")
    end
  end

end
