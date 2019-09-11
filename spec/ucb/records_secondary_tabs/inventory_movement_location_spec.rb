require_relative '../../../spec_helper'

[Deployment::PAHMA].each do |deploy|

  describe "#{deploy.name} Inventory / movement" do

    include Logging
    include WebDriverManager

    before(:all) do
      # Initialize the test config and browser
      @test = TestConfig.new deploy
      @test.set_driver launch_browser
      @test_data = @test.inventory_movement_test_data deploy
      @test_id = Time.now.to_i.to_s
      @admin = @test.get_admin_user

      # Initialize pages
      @login_page = @test.get_page CoreLoginPage
      @search_results_page = @test.get_page CoreSearchResultsPage
      @create_new_page = @test.get_page CoreCreateNewPage
      @object_page = @test.get_page CoreObjectPage
      @inventory_movement_page = @test.get_page CoreInventoryMovementPage
      @search_page = @test.get_page CoreSearchPage

      # Initialize test data and insert test ID
      @object = {PAHMAObjectData::OBJECT_NUM.name => @test_id}
      moves = []
      moves << (@move_0 = @test_data[0])
      moves << (@move_1 = @test_data[1])
      moves << (@move_2 = @test_data[2])
      moves << (@move_3 = @test_data[3])
      moves << (@move_4 = @test_data[4])
      moves << (@move_5 = @test_data[5])
      moves << (@move_6 = @test_data[6])
      moves << (@move_7 = @test_data[7])
      moves << (@move_8 = @test_data[8])
      moves.each_with_index do |data, index|
        data[PAHMAInventoryMovementData::CURRENT_LOCATION.name] = "Location #{index} #{@test_id}"
        data[PAHMAInventoryMovementData::CRATE.name] = "Crate #{index} #{@test_id}"
      end

      # Log in and create a test object
      @login_page.load_page
      @login_page.log_in(@admin.username, @admin.password)
      @search_page.click_create_new_link
      @create_new_page.click_create_new_object
      @object_page.enter_object_number @object
      @object_page.save_record
      @object.merge!(:url => @object_page.url)
    end

    after(:all) { quit_browser @test.driver }

    describe 'creation' do

      it 'can be done via Create New' do
        @object_page.click_create_new_link
        @create_new_page.click_create_new_movement
        @inventory_movement_page.create_unlocked_movement @move_0
      end

      it 'can be done on an object\'s secondary tab' do
        @object_page.get @object[:url]
        @object_page.click_movement_secondary_tab
        @object_page.click_create_new_button
        @inventory_movement_page.create_unlocked_movement @move_1
      end

      it 'can be done by cloning an existing inventory/movement on an object\'s secondary tab' do
        @inventory_movement_page.click_clone_button
        @inventory_movement_page.create_unlocked_movement @move_2
      end

      it 'can be created via another inventory/movement\'s secondary tab' do
        @inventory_movement_page.click_open_link
        @inventory_movement_page.click_movement_secondary_tab
        @inventory_movement_page.click_create_new_button
        @inventory_movement_page.create_unlocked_movement @move_3
      end
    end

    describe 'relating to an object' do

      it 'happens automatically when the inventory/movement is created via the object secondary tab' do
        @inventory_movement_page.get @move_0[:url]
        @inventory_movement_page.show_twenty_related_obj
        @inventory_movement_page.when_displayed(@inventory_movement_page.related_obj_link(@object_id), Config.short_wait)
      end

      context 'when done via the object secondary tab search' do

        before(:all) do
          # Create new movement
          @inventory_movement_page.click_create_new_link
          @create_new_page.click_create_new_movement
          @inventory_movement_page.create_unlocked_movement @move_4

          # Load the object's secondary movement tab, and relate the movement to it
          @object_page.get @object[:url]
          @object_page.click_movement_secondary_tab
          @object_page.click_relate_button
          @search_page.full_text_search @move_4[PAHMAInventoryMovementData::CURRENT_LOCATION.name]
          @search_results_page.wait_for_results
          @search_results_page.relate_records [@move_4[PAHMAInventoryMovementData::CURRENT_LOCATION.name]]
        end

        it 'shows the object on the inventory/movement\'s sidebar related objects' do
          @inventory_movement_page.get @move_4[:url]
          @inventory_movement_page.expand_sidebar_related_obj
          @inventory_movement_page.when_displayed(@inventory_movement_page.related_obj_link(@object[PAHMAObjectData::OBJECT_NUM.name]), Config.short_wait)
        end

        it 'shows the inventory/movement on the object\'s sidebar related procedures' do
          @inventory_movement_page.click_sidebar_related_obj @object[PAHMAObjectData::OBJECT_NUM.name]
          @object_page.show_twenty_related_proc
          @object_page.when_displayed(@object_page.related_proc_link(@move_4[PAHMAInventoryMovementData::CURRENT_LOCATION.name]), Config.short_wait)
        end
      end

      context 'when done via the object sidebar Related Actions' do

        before(:all) do
          # Create new movement
          @inventory_movement_page.click_create_new_link
          @create_new_page.click_create_new_movement
          @inventory_movement_page.create_unlocked_movement @move_5

          # Load the object's primary tab, and relate the movement to it via the sidebar Add link
          @object_page.get @object[:url]
          @object_page.click_add_related_procedure
          @search_page.full_text_search @move_5[PAHMAInventoryMovementData::CURRENT_LOCATION.name]
          @search_results_page.wait_for_results
          @search_results_page.relate_records [@move_5[PAHMAInventoryMovementData::CURRENT_LOCATION.name]]
        end

        it 'shows the inventory/movement on the object\'s sidebar related procedures' do
          @object_page.get @object[:url]
          @object_page.show_twenty_related_proc
          @object_page.when_displayed(@object_page.related_proc_link(@move_5[PAHMAInventoryMovementData::CURRENT_LOCATION.name]), Config.short_wait)
        end

        it 'shows the object on the inventory/movement\'s sidebar related objects' do
          @inventory_movement_page.get @move_5[:url]
          @inventory_movement_page.expand_sidebar_related_obj
          @inventory_movement_page.when_displayed(@inventory_movement_page.related_obj_link(@object[PAHMAObjectData::OBJECT_NUM.name]), Config.short_wait)
        end
      end

      context 'when done via the inventory/movement sidebar related objects' do

        before(:all) do
          # Create new movement
          @inventory_movement_page.click_create_new_link
          @create_new_page.click_create_new_movement
          @inventory_movement_page.create_unlocked_movement @move_6

          # Click the sidebar Add link, and relate the object to the movement
          @inventory_movement_page.click_add_related_object
          @search_page.full_text_search @object[PAHMAObjectData::OBJECT_NUM.name]
          @search_results_page.wait_for_results
          @search_results_page.relate_records [@object[PAHMAObjectData::OBJECT_NUM.name]]
        end

        it 'offers a link to a related object in the sidebar Related Objects' do
          @inventory_movement_page.expand_sidebar_related_obj
          @inventory_movement_page.click_sidebar_related_obj @object[PAHMAObjectData::OBJECT_NUM.name]
          @object_page.when_exists(@object_page.object_num_input, Config.short_wait)
          @object_page.wait_until(Config.short_wait) { @object_page.element_text(@object_page.page_h1) == @object[PAHMAObjectData::OBJECT_NUM.name] }
        end

        it 'is linked from the object\'s sidebar Related Actions' do
          @object_page.show_twenty_related_proc
          @object_page.click_sidebar_related_proc @move_6[PAHMAInventoryMovementData::CURRENT_LOCATION.name]
          @inventory_movement_page.when_displayed(@inventory_movement_page.current_location_input, Config.short_wait)
          expect(@inventory_movement_page.element_text @inventory_movement_page.page_h1).to include(@move_6[PAHMAInventoryMovementData::CURRENT_LOCATION.name])
        end
      end

      context 'when no later inventory/movement is related to the object' do

        before do
          # Create new movement
          @inventory_movement_page.click_create_new_link
          @create_new_page.click_create_new_movement
          @move_7.merge!({PAHMAInventoryMovementData::LOCATION_DATE.name => Date.today.strftime('%Y-%m-%d')})
          @inventory_movement_page.create_unlocked_movement @move_7

          # Load the object's secondary movement tab, and relate the movement to it
          @object_page.get @object[:url]
          @object_page.click_movement_secondary_tab
          @object_page.click_relate_button
          @search_page.full_text_search @move_7[PAHMAInventoryMovementData::CURRENT_LOCATION.name]
          @search_results_page.wait_for_results
          @search_results_page.relate_records [@move_7[PAHMAInventoryMovementData::CURRENT_LOCATION.name]]
        end

        it 'updates the object location and container with the later inventory/movement' do
          @object_page.get @object[:url]
          @object_page.wait_for_location @move_7
        end
      end

      context 'when a later inventory/movement is already related to the object' do

        it 'does not update the object location and container with the earlier inventory/movement' do
          @move_8.merge!({PAHMAInventoryMovementData::LOCATION_DATE.name => (Date.today - 1).strftime('%Y-%m-%d')})
          @object_page.get @object[:url]
          @object_page.click_movement_secondary_tab
          @object_page.click_create_new_button
          @inventory_movement_page.create_unlocked_movement @move_8
          @object_page.get @object[:url]
          @object_page.wait_for_location @move_7
        end
      end
    end

    describe 'relating to another inventory/movement' do

      it 'can be done via the inventory/movement secondary tab' do
        @inventory_movement_page.get @move_4[:url]
        @inventory_movement_page.click_movement_secondary_tab
        @inventory_movement_page.click_relate_button
        @search_page.full_text_search @move_0[PAHMAInventoryMovementData::CURRENT_LOCATION.name]
        @search_results_page.wait_for_results
        @search_results_page.relate_records [@move_0[PAHMAInventoryMovementData::CURRENT_LOCATION.name]]
      end

      it 'can be done via the inventory/movement sidebar Related Actions' do
        @inventory_movement_page.get @move_0[:url]
        @inventory_movement_page.click_add_related_procedure
        @search_page.full_text_search @move_2[PAHMAInventoryMovementData::CURRENT_LOCATION.name]
        @search_results_page.wait_for_results
        @search_results_page.relate_records [@move_2[PAHMAInventoryMovementData::CURRENT_LOCATION.name]]
      end
    end
  end
end
