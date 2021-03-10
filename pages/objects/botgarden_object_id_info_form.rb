module BOTGARDENObjectIdInfoForm

  include Logging
  include Page
  include CollectionSpacePages
  include CoreObjectIdInfoForm

  def botgarden_dead_flag_input; disabled_input_locator_by_label(BOTGARDENObjectData::DEAD_FLAG.label) end
  def botgarden_object_rarity; input_locator([], BOTGARDENObjectData::RARE.name) end

  # ACCESSION NUMBER
  def enter_botgarden_accession_num(data)
    wait_for_element_and_type(object_num_input, data[CoreObjectData::OBJECT_NUM.name])
  end

  # TAXONOMIC INFORMATION

  def enter_botgarden_taxonomics(data)
    enter_taxonomics(data, "Default")
  end

  def id_prefix_input_locator; input_locator([], BAMPFAObjectData::ID_PREFIX.name) end
  def id_year_input_locator; input_locator([], BAMPFAObjectData::ID_YEAR.name) end
  def id_gift_1_input_locator; input_locator([], BAMPFAObjectData::ID_GIFT_1.name) end
  def id_gift_2_input_locator; input_locator([], BAMPFAObjectData::ID_GIFT_2.name) end
  def id_gift_3_input_locator; input_locator([], BAMPFAObjectData::ID_GIFT_3.name) end
  def id_alpha_input_locator; input_locator([], BAMPFAObjectData::ID_ALPHA.name) end

  def artist_name_input(index); input_locator([fieldset(BAMPFAObjectData::ARTIST_MAKER_GRP.name, index)], BAMPFAObjectData::ARTIST_NAME.name) end
  def artist_name_options(index); input_options_locator([fieldset(BAMPFAObjectData::ARTIST_MAKER_GRP.name, index)], BAMPFAObjectData::ARTIST_NAME.name) end

  #Enter prefix of ID number information
  def enter_id_number(data)
    logger.debug "Entering ID number information"
    prefix = data[BAMPFAObjectData::ID_PREFIX.name]
    year = data[BAMPFAObjectData::ID_YEAR.name]
    gift_1 = data[BAMPFAObjectData::ID_GIFT_1.name]
    gift_2 = data[BAMPFAObjectData::ID_GIFT_2.name]
    gift_3 = data[BAMPFAObjectData::ID_GIFT_3.name]
    alpha = data[BAMPFAObjectData::ID_ALPHA.name]
    wait_for_element_and_type(id_prefix_input_locator, prefix) if prefix
    wait_for_element_and_type(id_year_input_locator, year) if year
    wait_for_element_and_type(id_prefix_input_locator, gift_1) if gift_1
    wait_for_element_and_type(id_prefix_input_locator, gift_2) if gift_2
    wait_for_element_and_type(id_prefix_input_locator, gift_3) if gift_3
    wait_for_element_and_type(id_prefix_input_locator, alpha) if alpha
  end

  #ARTIST OR MAKER field
  def enter_artist_or_maker(data)
    hide_notifications_bar
    artists = data[BAMPFAObjectData::ARTIST_MAKER_GRP.name]
    prep_fieldsets_for_test_data([fieldset(BAMPFAObjectData::ARTIST_MAKER_GRP.name)], artists)
    artists && artists.each_with_index do |artist, index|
      logger.info "Entering artist/maker '#{artist[BAMPFAObjectData::ARTIST_NAME.name]}'"
      enter_auto_complete(artist_name_input(index), artist_name_options(index), artist[BAMPFAObjectData::ARTIST_NAME.name])
    end
  end

end
