class CoreUCBLoginPage < CoreLoginPage

  DEPLOYMENT = Deployment::CORE_UCB

  # Loads the Core homepage
  def load_page
    logger.info 'Loading Core homepage'
    get ConfigCoreUCB.base_url
    when_exists(page_heading, Config.medium_wait)
  end

end
