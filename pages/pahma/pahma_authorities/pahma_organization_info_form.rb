require_relative '../../../spec_helper'

module PAHMAOrganizationInfoForm

  include Logging
  include Page
  include CollectionSpacePages

  DEPLOYMENT = Deployment::PAHMA

  def foundation_date_input; input_locator_by_label(PAHMAOrgData::FOUNDING_DATE.label) end

  def enter_foundation_date(test_data)
    test_date = test_data[CoreOrgData::FOUNDING_DATE.name]
    logger.info "Entering org foundation date: #{test_date}"
    hide_notifications_bar
    enter_simple_date(foundation_date_input, test_date)
  end

end
