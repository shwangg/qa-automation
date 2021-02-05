require_relative '../../../spec_helper'

test_run = TestConfig.new
test_run.deployment == Deployment::CORE

#floats and integers for testing
valid_floats = %w[.1234 0.1234 1234.0 -9.123]
invalid_floats = %w[123a 0.123a 123.123.123]
valid_integers = %w[1234 0 -1234]
invalid_integers = %w[123.0 1abc]

describe 'A CollectionSpace numeric field' do

  include Logging
  include WebDriverManager

  before(:all) do
    test_run.set_driver launch_browser
    @admin = test_run.get_admin_user
    @login_page = test_run.get_page CoreLoginPage
    @create_new_page = test_run.get_page CoreCreateNewPage
    @search_page = test_run.get_page CoreSearchPage
    @acquisition_page = test_run.get_page CoreAcquisitionPage
    @object_page = test_run.get_page CoreObjectPage
    @media_handling_page = test_run.get_page CoreMediaHandlingPage
    @object_exit_page = test_run.get_page CoreObjectExitPage
    @valuation_control_page = test_run.get_page CoreValuationControlPage

    @login_page.load_page
    @login_page.log_in(@admin.username, @admin.password)

    #all records will have ref/id num = @test_rec_num
    @test_rec_num = Time.now.to_i
  end

  before(:each) { @object_page.revert_record if @object_page.exists?(@object_page.revert_button) && @object_page.enabled?(@object_page.revert_button) }

  after(:all) { quit_browser test_run.driver }

  context 'when a user enters a value' do

    context 'in an acquisition record' do

      before(:all) do
        @test_acquisition = { CoreAcquisitionData::ACQUIS_REF_NUM.name => @test_rec_num }
        @object_page.click_create_new_link
        @create_new_page.click_create_new_acquisition
        @acquisition_page.create_new_acquisition @test_acquisition
      end

      context 'that are valid' do
        (valid_floats + valid_integers).each do |f|

          it "saves '#{f}' in the group purchase price field" do
            @test_acquisition.merge!({ CoreAcquisitionData::GRP_PURCHASE_PRICE_VALUE.name => f })
            @acquisition_page.enter_grp_purchase_price @test_acquisition
            @acquisition_page.save_record
          end

          it "saves '#{f}' in the object offer price field" do
            @test_acquisition.merge!({ CoreAcquisitionData::OBJ_OFFER_PRICE_VALUE.name => f })
            @acquisition_page.enter_obj_offer_price @test_acquisition
            @acquisition_page.save_record
          end

          it "saves '#{f}' in the object purchaser offer price field" do
            @test_acquisition.merge!({ CoreAcquisitionData::OBJ_PURCHASER_OFFER_PRICE_VALUE.name => f })
            @acquisition_page.enter_obj_purchaser_offer_price @test_acquisition
            @acquisition_page.save_record
          end

          it "saves '#{f}' in the object purchase price field" do
            @test_acquisition.merge!({ CoreAcquisitionData::OBJ_PURCHASE_PRICE_VALUE.name => f })
            @acquisition_page.enter_obj_purchase_price @test_acquisition
            @acquisition_page.save_record
          end

          it "saves '#{f}' in the original object purchase price field" do
            @test_acquisition.merge!({ CoreAcquisitionData::ORIG_OBJ_PURCHASE_PRICE_VALUE.name => f })
            @acquisition_page.enter_orig_obj_purchase_price @test_acquisition
            @acquisition_page.save_record
          end
        end
      end

      context 'that are invalid' do
        invalid_floats.each do |f|

          it "rejects '#{f}' in the group purchase price field" do
            @test_acquisition.merge!({ CoreAcquisitionData::GRP_PURCHASE_PRICE_VALUE.name => f })
            @acquisition_page.enter_grp_purchase_price @test_acquisition
            @acquisition_page.click_save_button
            @acquisition_page.wait_for_notification('must be a number. Correct the value')
          end

          it "rejects '#{f}' in the object offer price field" do
            @test_acquisition.merge!({ CoreAcquisitionData::OBJ_OFFER_PRICE_VALUE.name => f })
            @acquisition_page.enter_obj_offer_price @test_acquisition
            @acquisition_page.click_save_button
            @acquisition_page.wait_for_notification('must be a number. Correct the value')
          end

          it "rejects '#{f}' in the object purchaser offer price field" do
            @test_acquisition.merge!({ CoreAcquisitionData::OBJ_PURCHASER_OFFER_PRICE_VALUE.name => f })
            @acquisition_page.enter_obj_purchaser_offer_price @test_acquisition
            @acquisition_page.click_save_button
            @acquisition_page.wait_for_notification('must be a number. Correct the value')
          end

          it "rejects '#{f}' in the object purchase price field" do
            @test_acquisition.merge!({ CoreAcquisitionData::OBJ_PURCHASE_PRICE_VALUE.name => f })
            @acquisition_page.enter_obj_purchase_price @test_acquisition
            @acquisition_page.click_save_button
            @acquisition_page.wait_for_notification('must be a number. Correct the value')
          end

          it "rejects '#{f}' in the original object purchase price field" do
            @test_acquisition.merge!({ CoreAcquisitionData::ORIG_OBJ_PURCHASE_PRICE_VALUE.name => f })
            @acquisition_page.enter_orig_obj_purchase_price @test_acquisition
            @acquisition_page.click_save_button
            @acquisition_page.wait_for_notification('must be a number. Correct the value')
          end
        end
      end
    end

    context 'in a media handling record' do

      before(:all) do
        @object_page.revert_record if @object_page.exists?(@object_page.revert_button) && @object_page.enabled?(@object_page.revert_button)
        @test_media_handling = { CoreMediaHandlingData::ID_NUM.name => @test_rec_num }
        @acquisition_page.click_create_new_link
        @create_new_page.click_create_new_media_handling
        @media_handling_page.create_new_media @test_media_handling
      end

      context 'that are valid' do
        (valid_floats + valid_integers).each do |f|
          it "saves '#{f}' in the dimension measurement value field" do
            @media_handling_page.wait_for_element_and_type(@media_handling_page.dimens_measure_value_input([0, 0]), f)
            @media_handling_page.save_record
          end
        end
      end

      context 'that are invalid' do
        invalid_floats.each do |f|
          it "rejects '#{f}' in the dimension measurement value field" do
            @media_handling_page.wait_for_element_and_type(@media_handling_page.dimens_measure_value_input([0, 0]), f)
            @media_handling_page.click_save_button
            @media_handling_page.wait_for_notification('must be a number. Correct the value')
          end
        end
      end
    end

    context 'in an object exit record' do

      before(:all) do
        @object_page.revert_record if @object_page.exists?(@object_page.revert_button) && @object_page.enabled?(@object_page.revert_button)
        @test_object_exit = { CoreObjectExitData::EXIT_NUM.name => @test_rec_num }
        @media_handling_page.click_create_new_link
        @create_new_page.click_create_new_object_exit
        @object_exit_page.create_new_object_exit @test_object_exit
        @object_exit_page.expand_deaccession_info
      end

      context 'that are valid' do
        (valid_floats + valid_integers).each do |f|

          it "saves '#{f}' in the disposal value field" do
            @test_object_exit.merge!({ CoreObjectExitData::DISPOSAL_VALUE.name => f })
            @object_exit_page.enter_disposal_value @test_object_exit
            @object_exit_page.save_record
          end

          it "saves '#{f}' in the group disposal value field" do
            @test_object_exit.merge!({ CoreObjectExitData::GRP_DISPOSAL_VALUE.name => f })
            @object_exit_page.enter_grp_disposal_value @test_object_exit
            @object_exit_page.save_record
          end
        end
      end

      context 'that are invalid' do
        invalid_floats.each do |f|

          it "rejects '#{f}' in the disposal value field" do
            @test_object_exit.merge!({ CoreObjectExitData::DISPOSAL_VALUE.name => f })
            @object_exit_page.enter_disposal_value @test_object_exit
            @object_exit_page.click_save_button
            @object_exit_page.wait_for_notification('must be a number. Correct the value')
          end

          it "rejects '#{f}' in the group disposal value field" do
            @test_object_exit.merge!({ CoreObjectExitData::GRP_DISPOSAL_VALUE.name => f })
            @object_exit_page.enter_grp_disposal_value @test_object_exit
            @object_exit_page.click_save_button
            @object_exit_page.wait_for_notification('must be a number. Correct the value')
          end
        end
      end
    end

    context 'in a valuation control record' do

      before(:all) do
        @object_page.revert_record if @object_page.exists?(@object_page.revert_button) && @object_page.enabled?(@object_page.revert_button)
        @test_valuation_control = { CoreValuationControlData::VALUE_NUM.name => @test_rec_num }
        @object_exit_page.click_create_new_link
        @create_new_page.click_create_new_valuation_control
        @valuation_control_page.create_new_valuation_control @test_valuation_control
      end

      context 'that are valid' do
        (valid_floats + valid_integers).each do |f|
          it "saves '#{f}' in the amount field" do
            @test_valuation_control.merge!({ CoreValuationControlData::VALUE_AMT.name => f })
            @valuation_control_page.wait_for_element_and_type(@valuation_control_page.amount_input_loc(0), f)
            @valuation_control_page.save_record
          end
        end
      end

      context 'that are invalid' do
        invalid_floats.each do |f|
          it "rejects '#{f}' in the amount field" do
            @test_valuation_control.merge!({ CoreValuationControlData::VALUE_AMT.name => f })
            @valuation_control_page.wait_for_element_and_type(@valuation_control_page.amount_input_loc(0), f)
            @valuation_control_page.click_save_button
            @valuation_control_page.wait_for_notification('must be a number. Correct the value')
          end
        end
      end
    end

    context 'in an object record' do

      before(:all) do
        @object_page.revert_record if @object_page.exists?(@object_page.revert_button) && @object_page.enabled?(@object_page.revert_button)
        @test_object = { CoreObjectData::OBJECT_NUM.name => @test_rec_num }
        @search_page.click_create_new_link
        @create_new_page.click_create_new_object
        @object_page.create_new_object @test_object
        @object_page.expand_obj_desc_info
        @object_page.expand_obj_history_assoc_info
      end

      context 'that are valid' do
        valid_integers.each do |f|

          it "saves '#{f}' in the number of objects field" do
            @test_object.merge!({ CoreObjectData::NUM_OBJECTS.name => f })
            @object_page.enter_num_objects @test_object
            @object_page.save_record
          end

          it "saves '#{f}' in the age value field" do
            @test_object.merge!({ CoreObjectData::AGE.name => f })
            @object_page.enter_age_value @test_object
            @object_page.save_record
          end
        end

        (valid_floats + valid_integers).each do |f|

          it "saves '#{f}' in the dimension measurement value field" do
            @object_page.wait_for_element_and_type(@object_page.dimens_measure_value_input([0, 0]), f)
            @object_page.save_record
          end

          it "saves '#{f}' in the ownership exchange price value field" do
            @test_object.merge!({ CoreObjectData::OWNERSHIP_EXCH_PRICE_VALUE.name => f })
            @object_page.enter_ownership_exch_price_value @test_object
            @object_page.save_record
          end
        end
      end

      context 'that are invalid' do
        (valid_floats + invalid_integers).each do |f|

          it "rejects '#{f}' in the number of objects field" do
            @test_object.merge!({ CoreObjectData::NUM_OBJECTS.name => f })
            @object_page.enter_num_objects @test_object
            @object_page.click_save_button
            @object_page.wait_for_notification('must be an integer. Correct the value')
          end

          it "rejects '#{f}' in the age value field" do
            @test_object.merge!({ CoreObjectData::AGE.name => f })
            @object_page.enter_age_value @test_object
            @object_page.click_save_button
            @object_page.wait_for_notification('must be an integer. Correct the value')
          end
        end

        invalid_floats.each do |f|
          it "rejects '#{f}' in the dimension measurement value field" do
            @object_page.wait_for_element_and_type(@object_page.dimens_measure_value_input([0, 0]), f)
            @object_page.click_save_button
            @object_page.wait_for_notification('must be a number. Correct the value')
          end

          it "rejects '#{f}' in the ownership exchange price value field" do
            @test_object.merge!({ CoreObjectData::OWNERSHIP_EXCH_PRICE_VALUE.name => f })
            @object_page.enter_ownership_exch_price_value @test_object
            @object_page.click_save_button
            @object_page.wait_for_notification('must be a number. Correct the value')
          end
        end
      end
    end
  end
end
