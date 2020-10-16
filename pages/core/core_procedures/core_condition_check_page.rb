require_relative '../../../spec_helper'

# File was created in order to call the page in the create_quick_records test

class CoreConditionCheckPage
    include Logging
    include Page
    include CollectionSpacePages
    include CoreSidebar
    include CoreConditionCheckInfoForm
  
    DEPLOYMENT = Deployment::CORE

    def create_new_condition_check(data_set)
      enter_condition_check_info_data data_set
      click_save_button
      when_exists(delete_button, Config.short_wait)
    end

    def enter_number_and_text(data)
      enter_condition_ref_num data
      enter_condition_note data
    end
    
    def enter_number(data)
      enter_condition_ref_num data
    end
end
