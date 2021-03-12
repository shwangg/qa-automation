class AdminPage

  include Logging
  include Page
  include CollectionSpacePages

  # Locators
  def admin_users_link; {:xpath => '//a[contains(.,"Users")]'} end
  def admin_roles_link; {:xpath => '//a[contains(.,"Roles and Permissions")]'} end
  def email_field_locator; {:xpath => '//input[@data-name="email"]'} end
  def username_field_locator; {:xpath => '//input[@data-name="screenName"]'} end
  def password_field_locator; {:xpath => '//input[@data-name="password"]'} end
  def confirm_password_field_locator; {:xpath => '//input[@data-name="confirmPassword"]'} end
  def role_locator(role); {:xpath => "//fieldset[@data-name=\"roleList\"]//li[contains(.,\"#{role}\")]//input"} end
  def search_filter_bar; {:xpath => '//div[contains(@class, "AdminSearchBar")]//input[contains(@class,"LineInput")]'} end
  def result_rows; {:xpath => '//div[@class="cspace-ui-SearchResultTable--common"]//*[@aria-label="row"]'} end
  def role_name_locator; {:xpath => '//input[@data-name="displayName"]'} end
  def role_desc_locator; {:xpath => '//textarea[@data-name="description"]'} end

  def permission_locator(record_type, value); {:xpath  => "//section/div[contains(.,\"#{record_type}\")]//input[@value=\"#{value}\"]"} end

  # The following 4 methods are added temporarily while SearchPageResults is fixed...
  def fill_search_filter_bar(value)
    wait_for_element_and_type(search_filter_bar, value)
    sleep 1
  end

  def result_row(id)
    {:xpath => "//div[@class=\"cspace-ui-SearchResultTable--common\"]//*[@aria-label=\"row\"][contains(.,\"#{id}\")]"}
  end

  def wait_for_results
    wait_until(Config.short_wait) { elements(result_rows).any? }
  end

  def row_exists?(unique_identifier)
    exists? result_row(unique_identifier)
  end

  ###################
  ## User Creation ##
  ##################
  def click_users_link
    wait_for_page_and_click admin_users_link
  end

  # Creates a new user
  def create_new_user(user)
    logger.info "Creating user '#{user.name}'"
    click_element admin_users_link
    click_element create_new_button

    wait_for_element_and_type(email_field_locator, user.username)
    wait_for_element_and_type(username_field_locator, user.name)
    wait_for_element_and_type(password_field_locator, user.password)
    # Entering text in the password confirmation field is a bit flaky, so retry if it doesn't stick
    tries = 2
    begin
      tries -= 1
      wait_for_element_and_type(confirm_password_field_locator, user.password)
      hit_tab
      wait_until(1) { element_value(confirm_password_field_locator) == user.password }
    rescue => e
      logger.error e.message
      tries.zero? ? fail : retry
    end

    user.roles.each { |role| wait_for_element_and_click role_locator(role.name) }

    logger.debug "BENCHMARK ACTION - saving a new user"
    save_record
  end

  # Checks whether a user exists
  def user_exists?(user)
    click_element admin_users_link
    fill_search_filter_bar user.name
    exists? result_row(user.name)
  end

  # Change a user's role. Assumes the role exists
  def change_user_role(user, prev_role_name, new_role_name)
    logger.info "Changing #{user.name}'s role from #{prev_role_name} to #{new_role_name}"
    click_element admin_users_link

    fill_search_filter_bar user.name
    wait_for_results
    wait_for_element_and_click result_row(user.name)

    wait_for_element_and_click role_locator(prev_role_name)
    wait_for_element_and_click role_locator(new_role_name)

    logger.debug "BENCHMARK ACTION - saving a changed user role"
    save_record
  end

  def delete_user(user)
    logger.info "Deleting user '#{user.name}'"
    click_element admin_users_link
    fill_search_filter_bar user.name
    wait_for_results
    wait_for_element_and_click result_row(user.name)
    logger.debug "BENCHMARK ACTION - deleting a user"
    delete_record
  end

  #########################
  ## Roles & Permissions ##
  #########################
  def click_roles_link
    wait_for_page_and_click admin_roles_link
  end

  def role_exists?(role)
    click_element admin_roles_link
    fill_search_filter_bar role.name
    sleep 2
    exists? result_row(role.name)
  end

  # Creates a user role given a name, description and permissions
  def create_user_role(role)
    logger.info "Creating user role '#{role.name}'"
    click_element admin_roles_link
    click_element create_new_button
    wait_for_element_and_type(role_name_locator, role.name)
    change_role_permissions role.perms
    scroll_to_top
    hide_header_bar

    wait_for_element_and_type(role_desc_locator, role.description)

    wait_for_element_and_click top_save_button
    unhide_header_bar
  end

  # Takes in a Hash of mappings from Permission name to either "R, W, D, N"
  # Assumes role is checked for existence elsewhere
  def change_role_permissions(permissions)
    permissions.each do |key, value|
      logger.debug "Setting role permission '#{key}' to '#{value}'"
      case value
      when "N"
        revoke_permission key
      when "R"
        grant_read_permission key
      when "D"
        grant_delete_permission key
      when "W"
        grant_write_permissions key
      else
        "Error: Unknown permission type. Defaulting to NONE."
      end
    end
  end

  # Revokes permission from a record type
  def revoke_permission(record)
    wait_for_element_and_click permission_locator(record, "")
  end

  # Grants Read and List permission
  def grant_read_permission(record)
    wait_for_element_and_click permission_locator(record,  "RL")
  end

  # Grants Full CRUDL permissions
  def grant_delete_permission(record)
    wait_for_element_and_click permission_locator(record, "CRUDL")
  end

  # GRants Create, Read, List, Unrelate permissions
  def grant_write_permissions(record)
    wait_for_element_and_click permission_locator(record, "CRUL")
  end

  def delete_user_role(role)
    logger.info "Deleting user role '#{role.name}'"
    click_element admin_roles_link
    fill_search_filter_bar role.name
    wait_for_results
    wait_for_element_and_click result_row(role.name)
    logger.debug "BENCHMARK ACTION - deleting a user role"
    delete_record
  end

end