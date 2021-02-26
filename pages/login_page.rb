class LoginPage

  include Logging
  include Page
  include CollectionSpacePages

  def page_heading
    text = case @deployment
           when Deployment::BAMPFA
             'BAMPFA CollectionSpace'
           when Deployment::BOTGARDEN
             'UCBG CollectionSpace'
           when Deployment::CINEFILES
             'CineFiles CollectionSpace'
           when Deployment::PAHMA
             'PAHMA CollectionSpace'
           when Deployment::UCJEPS
             'UCJEPS CollectionSpace'
           else
             'CollectionSpace'
           end
    {:xpath => "//h2[contains(.,'#{text}')]"}
  end

  def username_input; {:id => 'username'} end
  def password_input; {:id => 'password'} end
  def sign_in_button; {:name => 'login'} end

  # Loads the Core homepage
  def load_page
    logger.info "Loading #{@deployment.name} homepage"
    get Config.base_url @deployment
    when_exists(page_heading, Config.medium_wait)
  end

  # Logs in from homepage
  # @param [String] username
  # @param [String] password
  def log_in(username, password)
    logger.info "Logging in as #{username}"
    wait_for_element_and_type(username_input, username)
    wait_for_element_and_type(password_input, password)
    wait_for_element_and_click sign_in_button
    when_exists(sign_out_link, Config.medium_wait)
  end

end
