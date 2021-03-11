module PAHMAAccessionInfoForm

  include Logging
  include Page
  include CollectionSpacePages
  include CoreAcquisitionInfoForm

  def enter_pahma_accession_info_form(data_set)
    hide_notifications_bar
    enter_acquisition_ref_num data_set
    enter_accession_date data_set
    enter_acquisition_dates data_set
    select_acquisition_method data_set
    select_acquisition_sources data_set
    enter_acquisition_note data_set
    enter_acquisition_reason data_set
    enter_acquisition_provisos data_set
    select_funding_sources data_set
    enter_credit_line data_set
    enter_obj_collection_info data_set
    enter_obj_offer_price(data_set)
    enter_obj_purchaser_offer_price(data_set)
    enter_obj_purchase_price(data_set)
    enter_orig_obj_purchase_price(data_set)
  end

end
