require_relative '../../../spec_helper'
deploy = Deployment::BOTGARDEN

describe 'BOTGARDEN' do

  include Logging
  include WebDriverManager

  before(:all) do
    @test = TestConfig.new deploy
    @test.set_driver launch_browser

    @admin = @test.get_admin_user
    @concept_page = @test.get_page CoreConceptPage
    @create_new_page = @test.get_page CoreCreateNewPage
    @login_page = @test.get_page CoreLoginPage
    @object_page = @test.get_page CoreObjectPage
    @search_page = @test.get_page CoreSearchPage
    @search_results_page = @test.get_page CoreSearchResultsPage
    @taxon_page = @test.get_page CoreUCBAuthorityPage

    @login_page.load_page
    @login_page.log_in(@admin.username, @admin.password)
  end

  after(:all) { quit_browser @test.driver }

  #Variables for tests
  scientific_name = "test"+Time.now.to_i.to_s
  obj_rec = {
    BOTGARDENObjectData::OBJECT_NUM.name => Time.now.to_i,
    BOTGARDENObjectData::TAXON_IDENT_GRP.name => [{BOTGARDENObjectData::TAXON_NAME.name => scientific_name}]
  }
  red_dot_record = "N/A"
  title_bar = {:xpath => '//header[contains(@class,"TitleBar")]//h1'}

  it "find conservation category value with set qualifier field" do
    @search_page.quick_search("Concepts", "Conservation Category", "red dot on label")
    red_dot_record = @search_results_page.name_of_nth_row(1)
    @search_results_page.select_result_nth_row(1)
    @concept_page.verify_qualifier_name("red dot on label", 0)
  end

  it "create a new object record for #{scientific_name} taxon" do
    @concept_page.click_create_new_link
    @create_new_page.click_create_new_object
    @object_page.enter_object_number obj_rec
    @object_page.enter_default_taxonomics obj_rec

    summary = "#{obj_rec[BOTGARDENObjectData::OBJECT_NUM.name]} – #{scientific_name}"
    @object_page.click_save_button
    @object_page.wait_for_notification("Saving #{summary}")
    @object_page.wait_for_notification("Saved #{summary}")
    @object_page.verify_values_match(summary, @object_page.element_text(title_bar))

    #value in Rare field should be "no"; if yes, enter a unique Taxon name for scientific_name
    #and re-run test (confirm that Rare = "no")
    expect(@object_page.element_value(@object_page.object_rarity) == "no").to be true
  end

  it "set Conservation category field to term with Qualifier" do
    @object_page.expand_sidebar_terms_used
    @object_page.click_sidebar_term(scientific_name)

    taxon = {BOTGARDENTaxonData::PLANT_ATTRIB_GRP.name => [{BOTGARDENTaxonData::CONSERV_CATEG.name => red_dot_record}]}
    @taxon_page.enter_attributes(taxon)
    @taxon_page.click_save_button

    summary = "#{scientific_name}" # no TERM_STATUS value created for new test taxon
    @object_page.verify_values_match(scientific_name, @taxon_page.element_text(title_bar))
    @taxon_page.wait_for_notification("Saving #{summary}")
    @taxon_page.wait_for_notification("Saved #{summary}")
    expect(@taxon_page.exists? @taxon_page.terms_used_term_link(red_dot_record))
  end

  it "confirm that the Rare field has been set to 'yes'" do
    @taxon_page.hide_notifications_bar
    @taxon_page.scroll_to_top
    @taxon_page.expand_sidebar_used_by
    @taxon_page.click_sidebar_used_by(obj_rec[BOTGARDENObjectData::OBJECT_NUM.name])

    @object_page.when_exists(@object_page.object_rarity, Config.short_wait)
    @object_page.scroll_to_element(@object_page.object_rarity)
    expect(@object_page.element_value(@object_page.object_rarity) == "yes").to be true
  end

end
