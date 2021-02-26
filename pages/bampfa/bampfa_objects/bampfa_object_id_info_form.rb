require_relative '../../../spec_helper'

module BAMPFAObjectIdInfoForm

  include Logging
  include Page
  include CollectionSpacePages

  DEPLOYMENT = Deployment::BAMPFA

 # ACCOUNT NUMBER PREFIX

 def acc_num_pref_input_locator; text_area_locator([], BAMPFAObjectData::ACC_NUM_PREF.name) end

 # Enters account info
 # @param [Hash] data_set
 def enter_acc_num_pref(data_set)
   pref = data_set[BAMPFAObjectData::ACC_NUM_PREF.name]
   logger.debug "Entering account info '#{pref}'"
   wait_for_element_and_type(acc_num_pref_input_locator, pref) if pref
 end

 # ACCOUNT NUMBER P1

 def acc_num_p1_input_locator; text_area_locator([], BAMPFAObjectData::ACC_NUM_P1.name) end

 # Enters account info
 # @param [Hash] data_set
 def enter_acc_num_p1(data_set)
   p1 = data_set[BAMPFAObjectData::ACC_NUM_P1.name]
   logger.debug "Entering account info '#{p1}'"
   wait_for_element_and_type(acc_num_pref_input_locator, p1) if p1
 end

  # ACCOUNT NUMBER P2

  def acc_num_p2_input_locator; text_area_locator([], BAMPFAObjectData::ACC_NUM_P2.name) end

  # Enters account info
  # @param [Hash] data_set
  def enter_acc_num_p2(data_set)
  p2 = data_set[BAMPFAObjectData::ACC_NUM_P2.name]
  logger.debug "Entering account info '#{p2}'"
  wait_for_element_and_type(acc_num_p2_input_locator, p2) if p2
  end

  # ACCOUNT NUMBER P3

  def acc_num_p3_input_locator; text_area_locator([], BAMPFAObjectData::ACC_NUM_P3.name) end

  # Enters account info
  # @param [Hash] data_set
  def enter_acc_num_p3(data_set)
  p3 = data_set[BAMPFAObjectData::ACC_NUM_P3.name]
  logger.debug "Entering account info '#{p3}'"
  wait_for_element_and_type(acc_num_p3_input_locator, p3) if p3
  end

  # ACCOUNT NUMBER P4

  def acc_num_p4_input_locator; text_area_locator([], BAMPFAObjectData::ACC_NUM_P4.name) end

  # Enters account info
  # @param [Hash] data_set
  def enter_acc_num_p4(data_set)
  p4 = data_set[BAMPFAObjectData::ACC_NUM_P4.name]
  logger.debug "Entering account info '#{p4}'"
  wait_for_element_and_type(acc_num_p4_input_locator, p4) if p4
  end

  # ACCOUNT NUMBER P5

  def acc_num_p5_input_locator; text_area_locator([], BAMPFAObjectData::ACC_NUM_P5.name) end

  # Enters account info
  # @param [Hash] data_set
  def enter_acc_num_p5(data_set)
  p5 = data_set[BAMPFAObjectData::ACC_NUM_P5.name]
  logger.debug "Entering account info '#{p5}'"
  wait_for_element_and_type(acc_num_p5_input_locator, p5) if p5
  end 

end