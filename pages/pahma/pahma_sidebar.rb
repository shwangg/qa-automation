require_relative '../../spec_helper'

module PAHMASidebar

  include CoreUCBSidebar

  def related_proc_button; button_locator('Actions') end
  def related_proc_expanded_div; expanded_div_locator('Actions') end
  def related_proc_links; links_locator('Actions') end
  def related_proc_link(proc); link_locator('Actions', proc) end
  def related_proc_num_per_page_input; num_per_page_input('Actions') end
  def related_proc_num_per_page_option; num_per_page_option('Actions') end

end
