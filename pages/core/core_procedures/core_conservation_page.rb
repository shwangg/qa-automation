require_relative '../../../spec_helper'

# File was created in order to call the page in the create_quick_records test

class CoreConservationPage
    include Logging
    include Page
    include CollectionSpacePages
    include CoreSidebar
    include CoreConservationInfoForm
  

    DEPLOYMENT = Deployment::CORE

    def enter_number_and_text(data)
        enter_conservation_ref_num data
        enter_conservation_note data
      end
      
      def enter_number(data)
        enter_conservation_ref_num data
      end    
end