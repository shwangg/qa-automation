require_relative '../../../spec_helper'

test_run = TestConfig.new Deployment::UCJEPS
test_id = Time.now.to_i
test_record = "Taxon test #{test_id}"

describe "A Collection Space #{test_run.deployment.name} taxon record" do

  include Logging
  include WebDriverManager

  before(:all) do
    test_run.set_driver launch_browser
    @admin = test_run.get_admin_user
    @login_page = test_run.get_page CoreLoginPage
    @create_new_page = test_run.get_page CoreCreateNewPage
    @taxon_page = TaxonPage.new test_run.driver
    @search_page = test_run.get_page CoreSearchPage

    @login_page.load_page
    @login_page.log_in(@admin.username, @admin.password)
  end

  after(:all) { quit_browser test_run.driver }

  it 'shows no Formatted Display Name on a new, unsaved record' do
    @search_page.click_create_new_link
    @create_new_page.click_create_new_authority_taxon_default
    @taxon_page.enter_term_display_name(test_record, 0)
    @taxon_page.hit_tab
    expect(@taxon_page.element_text @taxon_page.formatted_display_name).to be_empty
  end

  it 'shows a calculated Formatted Display Name on a new, saved record' do
    @taxon_page.save_record
    @taxon_page.wait_until(Config.short_wait) { @taxon_page.element_text(@taxon_page.formatted_display_name) == test_record }
  end

  it 'allows a user to manually override the Formatted Display Name' do
    @taxon_page.enter_formatted_display_name 'Harmonia axyridis L.'
    @taxon_page.hit_tab
    @taxon_page.save_record
    sleep 1
    @taxon_page.wait_until(Config.short_wait) { @taxon_page.element_text(@taxon_page.formatted_display_name) == 'Harmonia axyridis L.' }
  end

  it 'reverts to a calculated Formatted Display Name if the field is manually cleared' do
    @taxon_page.enter_formatted_display_name ''
    @taxon_page.save_record
    @taxon_page.wait_until(Config.short_wait) { @taxon_page.element_text(@taxon_page.formatted_display_name) == test_record }
  end

  it 'updates the Formatted Display Name if the display name is updated' do
    @taxon_page.enter_term_display_name((test_record = "#{test_record} edited"), 0)
    @taxon_page.enter_formatted_display_name ''
    @taxon_page.save_record
    @taxon_page.wait_until(Config.short_wait) { @taxon_page.element_text(@taxon_page.formatted_display_name) == test_record }
  end
end
