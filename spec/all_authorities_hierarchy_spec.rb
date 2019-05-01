require_relative '../spec_helper'

describe 'Authority hierarchy', order: :defined do

  include Logging
  include WebDriverManager

  test_run = TestConfig.new
  test_id = Time.now.to_i

  before(:all) do
    test_run.set_driver launch_browser
    @admin = test_run.get_admin_user
    @login_page = test_run.get_page LoginPage
    @create_new_page = test_run.get_page CreateNewPage
    @org_authority_page = test_run.get_page OrganizationPage
    @search_page = test_run.get_page SearchPage
    @search_results_page = test_run.get_page SearchResultsPage

    @foo_1 = "Foo One #{test_id}"
    @foo_2 = "Foo Two #{test_id}"
    @foo_3a = "Foo Three A #{test_id}"
    @foo_3b = "Foo Three B #{test_id}"
    @foo_4aa = "Foo Four AA #{test_id}"
    @foo_4ab = "Foo Four AB #{test_id}"
    @foo_4ac = "Foo Four AC #{test_id}"
    @foo_4ba = "Foo Four BA #{test_id}"
    @foo_4bb = "Foo Four BB #{test_id}"
    @bar = "Bar #{test_id + 1}"

    @login_page.load_page
    @login_page.log_in(@admin.username, @admin.password)
  end

  after(:all) { quit_browser test_run.driver }

  describe 'creation' do

    before(:all) do
      @search_page.click_create_new_link
      @create_new_page.click_create_new_org_local
    end

    it 'allows a user to create an org authority with a broader context and two narrower contexts' do
      @org_authority_page.enter_display_name(@foo_2, 0)
      @org_authority_page.expand_hierarchy
      @org_authority_page.add_broader_auth @foo_1
      @org_authority_page.add_narrower_auths [@foo_3a, @foo_3b]
      @org_authority_page.save_record
      @org_authority_page.verify_display_name(@foo_2, 0)
      errors = @org_authority_page.verify_hierarchy(@foo_1, [], [@foo_3a, @foo_3b])
      expect(errors).to be_empty
    end

    it 'allows a user to modify an org authority by adding narrower contexts' do
      @org_authority_page.quick_search('Organizations', @foo_3a)
      @search_results_page.click_result @foo_3a
      @org_authority_page.expand_hierarchy
      @org_authority_page.add_narrower_auths [@foo_4aa, @foo_4ab]
      @org_authority_page.save_record
      @org_authority_page.verify_display_name(@foo_3a, 0)
      errors = @org_authority_page.verify_hierarchy(@foo_2, [@foo_3b], [@foo_4aa, @foo_4ab])
      expect(errors).to be_empty
    end

    it 'allows a user to add one narrower context to an org authority with existing narrower contexts' do
      @org_authority_page.add_narrower_auths [@foo_4ac]
      @org_authority_page.save_record
      errors = @org_authority_page.verify_hierarchy(@foo_2, [@foo_3b], [@foo_4aa, @foo_4ab, @foo_4ac])
      expect(errors).to be_empty
    end

    it 'allows a user to view a an org hierarchy with a broader context and sibling contexts but no narrower contexts' do
      @org_authority_page.quick_search('Organizations', @foo_4aa)
      @search_results_page.click_result @foo_4aa
      @org_authority_page.expand_hierarchy
      errors = @org_authority_page.verify_hierarchy(@foo_3a, [@foo_4ab, @foo_4ac], [])
      expect(errors).to be_empty
    end

    it 'allows a user to view an org hierarchy with a broader context and sibling context but no narrower contexts' do
      @org_authority_page.quick_search('Organizations', @foo_3b)
      @search_results_page.click_result @foo_3b
      @org_authority_page.expand_hierarchy
      errors = @org_authority_page.verify_hierarchy(@foo_2, [@foo_3a], [])
      expect(errors).to be_empty
    end

    it 'allows a user to add multiple narrower context to an org authority with no narrower contexts' do
      @org_authority_page.add_narrower_auths [@foo_4ba, @foo_4bb]
      @org_authority_page.save_record
      errors = @org_authority_page.verify_hierarchy(@foo_2, [@foo_3a], [@foo_4ba, @foo_4bb])
      expect(errors).to be_empty
    end

    it 'allows a user to search for all members of a org authority hierarchy' do
      @org_authority_page.quick_search('Organizations', test_id)
      @search_results_page.wait_for_results
      expect(@search_results_page.exists? @search_results_page.result_row(@foo_1)).to be true
      expect(@search_results_page.exists? @search_results_page.result_row(@foo_2)).to be true
      expect(@search_results_page.exists? @search_results_page.result_row(@foo_3a)).to be true
      expect(@search_results_page.exists? @search_results_page.result_row(@foo_3b)).to be true
      expect(@search_results_page.exists? @search_results_page.result_row(@foo_4aa)).to be true
      expect(@search_results_page.exists? @search_results_page.result_row(@foo_4ab)).to be true
      expect(@search_results_page.exists? @search_results_page.result_row(@foo_4ac)).to be true
      expect(@search_results_page.exists? @search_results_page.result_row(@foo_4ba)).to be true
      expect(@search_results_page.exists? @search_results_page.result_row(@foo_4bb)).to be true
    end

    it 'allows a user to view an org authority hierarchy from the broadest context' do
      @search_results_page.click_result @foo_1
      @org_authority_page.expand_hierarchy
      errors = @org_authority_page.verify_hierarchy(nil, [], [@foo_2])
      expect(errors).to be_empty
    end

    it 'allows a user to view an org authority hierarchy from the narrowest context' do
      @org_authority_page.quick_search('Organizations', test_id)
      @search_results_page.click_result @foo_4bb
      @org_authority_page.expand_hierarchy
      errors = @org_authority_page.verify_hierarchy(@foo_3b, [@foo_4ba], [])
      expect(errors).to be_empty
    end
  end

  describe 'editing' do

    before(:all) do
      @search_page.click_create_new_link
      @create_new_page.click_create_new_org_local
    end

    it 'warns a user before allowing a hierarchy member to be moved to a different hierarchy' do
      @org_authority_page.enter_display_name(@bar, 0)
      @org_authority_page.add_narrower_auths [@foo_4ba]
      @org_authority_page.wait_for_notification "#{@foo_4ba} currently has the broader record #{@foo_3b}. Its broader record will be changed when this record is saved."
    end

    it 'allows a user to move a hierarchy member to a different hierarchy' do
      @org_authority_page.save_record
      @org_authority_page.verify_display_name(@bar, 0)
      errors = @org_authority_page.verify_hierarchy(nil, [], [@foo_4ba])
      expect(errors).to be_empty
    end

    it 'shows a user the right hierarchy after a modification' do
      @org_authority_page.mouseover @org_authority_page.narrower_input(0)
      @org_authority_page.click_term_popup_link @foo_4ba
      errors = @org_authority_page.verify_hierarchy(@bar, [], [])
      expect(errors).to be_empty
    end

    it 'prevents a user from deleting a hierarchy member with both broader and narrower contexts' do
      @org_authority_page.quick_search('Organizations', @foo_3a)
      @search_results_page.click_result @foo_3a
      @org_authority_page.click_delete_button
      expect(@org_authority_page.confirm_delete_msg).to include("#{@foo_3a} cannot be deleted because it belongs to a hierarchy. To delete this record, first remove its broader and narrower records.")
    end

    it 'prevents a user from deleting a hierarchy member with only narrower contexts' do
      @org_authority_page.cancel_deletion
      @org_authority_page.remove_broader_auth
      @org_authority_page.save_record
      @org_authority_page.click_delete_button
      expect(@org_authority_page.confirm_delete_msg).to include("#{@foo_3a} cannot be deleted because it belongs to a hierarchy. To delete this record, first remove its broader and narrower records.")
    end

    it 'prevents a user from deleting a hierarchy member with narrow contexts and a newly added broader context' do
      @org_authority_page.cancel_deletion
      @org_authority_page.add_broader_auth @foo_2
      @org_authority_page.save_record
      @org_authority_page.click_delete_button
      expect(@org_authority_page.confirm_delete_msg).to include("#{@foo_3a} cannot be deleted because it belongs to a hierarchy. To delete this record, first remove its broader and narrower records.")
    end

  end
end
