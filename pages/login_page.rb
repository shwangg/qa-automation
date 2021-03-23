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
  end

  # Logs in from homepage
  # @param [String] username
  # @param [String] password
  def log_in(username, password)
    logger.info "Logging in as #{username}"
    start = Time.now
    finish = wait_for_element_and_type(username_input, username)
    logger.debug "BENCHMARK - took #{finish - start} seconds for username input to appear"
    wait_for_element_and_type(password_input, password)
    wait_for_element_and_click sign_in_button
    start = Time.now
    when_exists(sign_out_link, Config.medium_wait)
    logger.debug "BENCHMARK - took #{Time.now - start} seconds for login to complete"
  end

end
