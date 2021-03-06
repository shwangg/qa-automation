module BAMPFAObjectIdInfoForm

  include Logging
  include Page
  include CollectionSpacePages

  DEPLOYMENT = Deployment::BAMPFA

 # ACCOUNT NUMBER PREFIX

 def acc_num_pref_input_locator; input_locator([], BAMPFAObjectData::ID_PREFIX.name) end
 # Enters account info
 # @param [Hash] data_set
 def enter_bampfa_id_prefix(data_set)
   pref = data_set[BAMPFAObjectData::ID_PREFIX.name]
   logger.debug "Entering account info '#{pref}'"
   wait_for_element_and_type(acc_num_pref_input_locator, pref) if pref
 end

 # ACCOUNT NUMBER YEAR

 def acc_num_p1_input_locator; input_locator([], BAMPFAObjectData::ID_YEAR.name) end

 # Enters account info
 # @param [Hash] data_set
 def enter_bampfa_id_year(data_set)
   p1 = data_set[BAMPFAObjectData::ID_YEAR.name]
   logger.debug "Entering account info '#{p1}'"
   wait_for_element_and_type(acc_num_p1_input_locator, p1) if p1
 end

  # ACCOUNT NUMBER GIFT 1

  def acc_num_p2_input_locator; input_locator([], BAMPFAObjectData::ID_GIFT_1.name) end

  # Enters account info
  # @param [Hash] data_set
  def enter_bampfa_id_gift_1(data_set)
    p2 = data_set[BAMPFAObjectData::ID_GIFT_1.name]
    logger.debug "Entering account info '#{p2}'"
    wait_for_element_and_type(acc_num_p2_input_locator, p2) if p2
  end

  # ACCOUNT NUMBER GIFT 2

  def acc_num_p3_input_locator; input_locator([], BAMPFAObjectData::ID_GIFT_2.name) end

  # Enters account info
  # @param [Hash] data_set
  def enter_bampfa_id_gift_2(data_set)
    p3 = data_set[BAMPFAObjectData::ID_GIFT_2.name]
    logger.debug "Entering account info '#{p3}'"
    wait_for_element_and_type(acc_num_p3_input_locator, p3) if p3
  end

  # ACCOUNT NUMBER GIFT 3

  def acc_num_p4_input_locator; input_locator([], BAMPFAObjectData::ID_GIFT_3.name) end

  # Enters account info
  # @param [Hash] data_set
  def enter_bampfa_id_gift_3(data_set)
    p4 = data_set[BAMPFAObjectData::ID_GIFT_3.name]
    logger.debug "Entering account info '#{p4}'"
    wait_for_element_and_type(acc_num_p4_input_locator, p4) if p4
  end

  # ACCOUNT NUMBER ALPHA

  def acc_num_p5_input_locator; input_locator([], BAMPFAObjectData::ID_ALPHA.name) end

  # Enters account info
  # @param [Hash] data_set
  def enter_bampfa_id_alpha(data_set)
    p5 = data_set[BAMPFAObjectData::ID_ALPHA.name]
    logger.debug "Entering account info '#{p5}'"
    wait_for_element_and_type(acc_num_p5_input_locator, p5) if p5
  end 


    # ARTIST NAME

  def artist_name_input_locator(index); input_locator([fieldset(BAMPFAObjectData::ARTIST_MAKER_GRP.name, index)], BAMPFAObjectData::ARTIST_NAME.name) end

  # Selects a set of artist names
  # @param [Hash] data_set
  def select_bampfa_artist_name(data_set)
    artists = data_set[BAMPFAObjectData::ARTIST_MAKER_GRP.name]
    artists && artists.each_with_index do |artists, index|
      logger.debug "Entering artists name #{artists} at index #{index}"
      artists_name_options_locator = input_options_locator([fieldset(BAMPFAObjectData::ARTIST_MAKER_GRP.name, index)], BAMPFAObjectData::ARTIST_NAME.name)
    #   wait_for_element_and_click add_button_locator([fieldset(BAMPFAObjectData::ARTIST_MAKER_GRP.name)]) unless index.zero?
      enter_auto_complete(artist_name_input_locator(index), artists_name_options_locator, artists[BAMPFAObjectData::ARTIST_NAME.name], 'Local Persons')
    end
  end
end

  

