require_relative '../../../spec_helper'

describe 'PAHMA structured dates' do

  include Logging
  include WebDriverManager
  
  before(:all) do
    @test = TestConfig.new Deployment::PAHMA
    @test.set_driver launch_browser
    @test_data = {}
    @test.set_unique_test_id(@test_data, PAHMAObjectData::OBJECT_NUM.name)

    @admin = @test.get_admin_user
    @login_page = LoginPage.new @test
    @search_page = SearchPage.new @test
    @create_new_page = CreateNewPage.new @test
    @object_page = ObjectPage.new @test

    @login_page.load_page
    @login_page.log_in(@admin.username, @admin.password)
    @search_page.click_create_new_link
    @create_new_page.click_create_new_object
    @object_page.wait_for_element_and_type(@object_page.object_num_input, @test_data[PAHMAObjectData::OBJECT_NUM.name])
  end

  after(:all) { quit_browser @test.driver }

  context 'when "ca. 69 BC" is entered' do
    before do
      @object_page.wait_for_element_and_type(@object_page.taxon_date_input(0), 'ca. 69 BC')
      @object_page.hit_enter
    end

    it 'generates an earliest date 5 years prior and a latest date 5 years after' do
      @object_page.wait_until(1) { !@object_page.element_value(@object_page.date_earliest_year).empty? }
      expect(@object_page.element_value @object_page.date_earliest_year).to eql('74')
      expect(@object_page.element_value @object_page.date_earliest_month).to eql('1')
      expect(@object_page.element_value @object_page.date_earliest_day).to eql('1')
      expect(@object_page.element_value @object_page.date_earliest_era).to eql('BCE')
      expect(@object_page.element_value @object_page.date_latest_year).to eql('64')
      expect(@object_page.element_value @object_page.date_latest_month).to eql('12')
      expect(@object_page.element_value @object_page.date_latest_day).to eql('31')
      expect(@object_page.element_value @object_page.date_latest_era).to eql('BCE')
    end
  end

  context 'when "ca. 60 BC" is entered' do
    before do
      @object_page.wait_for_element_and_type(@object_page.taxon_date_input(0), 'ca. 60 BC')
      @object_page.hit_enter
    end

    it 'generates an earliest date 10 years prior and a latest date 10 years after' do
      @object_page.wait_until(1) { !@object_page.element_value(@object_page.date_earliest_year).empty? }
      expect(@object_page.element_value @object_page.date_earliest_year).to eql('70')
      expect(@object_page.element_value @object_page.date_earliest_month).to eql('1')
      expect(@object_page.element_value @object_page.date_earliest_day).to eql('1')
      expect(@object_page.element_value @object_page.date_earliest_era).to eql('BCE')
      expect(@object_page.element_value @object_page.date_latest_year).to eql('50')
      expect(@object_page.element_value @object_page.date_latest_month).to eql('12')
      expect(@object_page.element_value @object_page.date_latest_day).to eql('31')
      expect(@object_page.element_value @object_page.date_latest_era).to eql('BCE')
    end
  end

  context 'when "ca. 200 BC" is entered' do
    before do
      @object_page.wait_for_element_and_type(@object_page.taxon_date_input(0), 'ca. 200 BC')
      @object_page.hit_enter
    end

    it 'generates an earliest date 50 years prior and a latest date 50 years after' do
      @object_page.wait_until(1) { !@object_page.element_value(@object_page.date_earliest_year).empty? }
      expect(@object_page.element_value @object_page.date_earliest_year).to eql('250')
      expect(@object_page.element_value @object_page.date_earliest_month).to eql('1')
      expect(@object_page.element_value @object_page.date_earliest_day).to eql('1')
      expect(@object_page.element_value @object_page.date_earliest_era).to eql('BCE')
      expect(@object_page.element_value @object_page.date_latest_year).to eql('150')
      expect(@object_page.element_value @object_page.date_latest_month).to eql('12')
      expect(@object_page.element_value @object_page.date_latest_day).to eql('31')
      expect(@object_page.element_value @object_page.date_latest_era).to eql('BCE')
    end
  end

  context 'when "ca. 1000 BC" is entered' do
    before do
      @object_page.wait_for_element_and_type(@object_page.taxon_date_input(0), 'ca. 1000 BC')
      @object_page.hit_enter
    end

    it 'generates an earliest date 500 years prior and a latest date 500 years after' do
      @object_page.wait_until(1) { !@object_page.element_value(@object_page.date_earliest_year).empty? }
      expect(@object_page.element_value @object_page.date_earliest_year).to eql('1500')
      expect(@object_page.element_value @object_page.date_earliest_month).to eql('1')
      expect(@object_page.element_value @object_page.date_earliest_day).to eql('1')
      expect(@object_page.element_value @object_page.date_earliest_era).to eql('BCE')
      expect(@object_page.element_value @object_page.date_latest_year).to eql('500')
      expect(@object_page.element_value @object_page.date_latest_month).to eql('12')
      expect(@object_page.element_value @object_page.date_latest_day).to eql('31')
      expect(@object_page.element_value @object_page.date_latest_era).to eql('BCE')
    end
  end

  context 'when "3100±150 BP" is entered' do
    before do
      @object_page.wait_for_element_and_type(@object_page.taxon_date_input(0), '3100±150 BP')
      @object_page.hit_enter
    end

    it 'generates an earliest and latest BC year range of 300 years' do
      @object_page.wait_until(1) { !@object_page.element_value(@object_page.date_earliest_year).empty? }
      expect(@object_page.element_value @object_page.date_earliest_year).to eql('1300')
      expect(@object_page.element_value @object_page.date_earliest_month).to eql('1')
      expect(@object_page.element_value @object_page.date_earliest_day).to eql('1')
      expect(@object_page.element_value @object_page.date_earliest_era).to eql('BCE')
      expect(@object_page.element_value @object_page.date_latest_year).to eql('1000')
      expect(@object_page.element_value @object_page.date_latest_month).to eql('12')
      expect(@object_page.element_value @object_page.date_latest_day).to eql('31')
      expect(@object_page.element_value @object_page.date_latest_era).to eql('BCE')
    end
  end

  context 'when "3,100±150 BP" is entered' do
    before do
      @object_page.wait_for_element_and_type(@object_page.taxon_date_input(0), '3,100±150 BP')
      @object_page.hit_enter
    end

    it 'generates an earliest and latest BC year range of 300 years' do
      @object_page.wait_until(1) { !@object_page.element_value(@object_page.date_earliest_year).empty? }
      expect(@object_page.element_value @object_page.date_earliest_year).to eql('1300')
      expect(@object_page.element_value @object_page.date_earliest_month).to eql('1')
      expect(@object_page.element_value @object_page.date_earliest_day).to eql('1')
      expect(@object_page.element_value @object_page.date_earliest_era).to eql('BCE')
      expect(@object_page.element_value @object_page.date_latest_year).to eql('1000')
      expect(@object_page.element_value @object_page.date_latest_month).to eql('12')
      expect(@object_page.element_value @object_page.date_latest_day).to eql('31')
      expect(@object_page.element_value @object_page.date_latest_era).to eql('BCE')
    end
  end

  context 'when "3100 ± 150 BP" is entered' do
    before do
      @object_page.wait_for_element_and_type(@object_page.taxon_date_input(0), '3100 ± 150 BP')
      @object_page.hit_enter
    end

    it 'generates an earliest and latest BC year range of 300 years' do
      @object_page.wait_until(1) { !@object_page.element_value(@object_page.date_earliest_year).empty? }
      expect(@object_page.element_value @object_page.date_earliest_year).to eql('1300')
      expect(@object_page.element_value @object_page.date_earliest_month).to eql('1')
      expect(@object_page.element_value @object_page.date_earliest_day).to eql('1')
      expect(@object_page.element_value @object_page.date_earliest_era).to eql('BCE')
      expect(@object_page.element_value @object_page.date_latest_year).to eql('1000')
      expect(@object_page.element_value @object_page.date_latest_month).to eql('12')
      expect(@object_page.element_value @object_page.date_latest_day).to eql('31')
      expect(@object_page.element_value @object_page.date_latest_era).to eql('BCE')
    end
  end

  context 'when "3100 ± 150 years BP" is entered' do
    before do
      @object_page.wait_for_element_and_type(@object_page.taxon_date_input(0), '3100 ± 150 years BP')
      @object_page.hit_enter
    end

    it 'generates an earliest and latest BC year range of 300 years' do
      @object_page.wait_until(1) { !@object_page.element_value(@object_page.date_earliest_year).empty? }
      expect(@object_page.element_value @object_page.date_earliest_year).to eql('1300')
      expect(@object_page.element_value @object_page.date_earliest_month).to eql('1')
      expect(@object_page.element_value @object_page.date_earliest_day).to eql('1')
      expect(@object_page.element_value @object_page.date_earliest_era).to eql('BCE')
      expect(@object_page.element_value @object_page.date_latest_year).to eql('1000')
      expect(@object_page.element_value @object_page.date_latest_month).to eql('12')
      expect(@object_page.element_value @object_page.date_latest_day).to eql('31')
      expect(@object_page.element_value @object_page.date_latest_era).to eql('BCE')
    end
  end

  context 'when "3100+/-150 BP" is entered' do
    before do
      @object_page.wait_for_element_and_type(@object_page.taxon_date_input(0), '3100+/-150 BP')
      @object_page.hit_enter
    end

    it 'generates an earliest and latest BC year range of 300 years' do
      @object_page.wait_until(1) { !@object_page.element_value(@object_page.date_earliest_year).empty? }
      expect(@object_page.element_value @object_page.date_earliest_year).to eql('1300')
      expect(@object_page.element_value @object_page.date_earliest_month).to eql('1')
      expect(@object_page.element_value @object_page.date_earliest_day).to eql('1')
      expect(@object_page.element_value @object_page.date_earliest_era).to eql('BCE')
      expect(@object_page.element_value @object_page.date_latest_year).to eql('1000')
      expect(@object_page.element_value @object_page.date_latest_month).to eql('12')
      expect(@object_page.element_value @object_page.date_latest_day).to eql('31')
      expect(@object_page.element_value @object_page.date_latest_era).to eql('BCE')
    end
  end

  context 'when "3100 +/- 150 BP" is entered' do
    before do
      @object_page.wait_for_element_and_type(@object_page.taxon_date_input(0), '3100 +/- 150 BP')
      @object_page.hit_enter
    end

    it 'generates an earliest and latest BC year range of 300 years' do
      @object_page.wait_until(1) { !@object_page.element_value(@object_page.date_earliest_year).empty? }
      expect(@object_page.element_value @object_page.date_earliest_year).to eql('1300')
      expect(@object_page.element_value @object_page.date_earliest_month).to eql('1')
      expect(@object_page.element_value @object_page.date_earliest_day).to eql('1')
      expect(@object_page.element_value @object_page.date_earliest_era).to eql('BCE')
      expect(@object_page.element_value @object_page.date_latest_year).to eql('1000')
      expect(@object_page.element_value @object_page.date_latest_month).to eql('12')
      expect(@object_page.element_value @object_page.date_latest_day).to eql('31')
      expect(@object_page.element_value @object_page.date_latest_era).to eql('BCE')
    end
  end

  context 'when "3100 +/- 150 years BP" is entered' do
    before do
      @object_page.wait_for_element_and_type(@object_page.taxon_date_input(0), '3100 +/- 150 years BP')
      @object_page.hit_enter
    end

    it 'generates an earliest and latest BC year range of 300 years' do
      @object_page.wait_until(1) { !@object_page.element_value(@object_page.date_earliest_year).empty? }
      expect(@object_page.element_value @object_page.date_earliest_year).to eql('1300')
      expect(@object_page.element_value @object_page.date_earliest_month).to eql('1')
      expect(@object_page.element_value @object_page.date_earliest_day).to eql('1')
      expect(@object_page.element_value @object_page.date_earliest_era).to eql('BCE')
      expect(@object_page.element_value @object_page.date_latest_year).to eql('1000')
      expect(@object_page.element_value @object_page.date_latest_month).to eql('12')
      expect(@object_page.element_value @object_page.date_latest_day).to eql('31')
      expect(@object_page.element_value @object_page.date_latest_era).to eql('BCE')
    end
  end

  context 'when "1200±50 BP" is entered' do
    before do
      @object_page.wait_for_element_and_type(@object_page.taxon_date_input(0), '1200±50 BP')
      @object_page.hit_enter
    end

    it 'generates an earliest and latest AD year range of 100 years' do
      @object_page.wait_until(1) { !@object_page.element_value(@object_page.date_earliest_year).empty? }
      expect(@object_page.element_value @object_page.date_earliest_year).to eql('700')
      expect(@object_page.element_value @object_page.date_earliest_month).to eql('1')
      expect(@object_page.element_value @object_page.date_earliest_day).to eql('1')
      expect(@object_page.element_value @object_page.date_earliest_era).to eql('CE')
      expect(@object_page.element_value @object_page.date_latest_year).to eql('800')
      expect(@object_page.element_value @object_page.date_latest_month).to eql('12')
      expect(@object_page.element_value @object_page.date_latest_day).to eql('31')
      expect(@object_page.element_value @object_page.date_latest_era).to eql('CE')
    end
  end

  context 'when "2000±100 BP" is entered' do
    before do
      @object_page.wait_for_element_and_type(@object_page.taxon_date_input(0), '2000±100 BP')
      @object_page.hit_enter
    end

    it 'generates an earliest BC year and latest AD year range of 200 years' do
      @object_page.wait_until(1) { !@object_page.element_value(@object_page.date_earliest_year).empty? }
      expect(@object_page.element_value @object_page.date_earliest_year).to eql('150')
      expect(@object_page.element_value @object_page.date_earliest_month).to eql('1')
      expect(@object_page.element_value @object_page.date_earliest_day).to eql('1')
      expect(@object_page.element_value @object_page.date_earliest_era).to eql('BCE')
      expect(@object_page.element_value @object_page.date_latest_year).to eql('50')
      expect(@object_page.element_value @object_page.date_latest_month).to eql('12')
      expect(@object_page.element_value @object_page.date_latest_day).to eql('31')
      expect(@object_page.element_value @object_page.date_latest_era).to eql('CE')
    end
  end

  context 'when "5580-5460 BC" is entered' do
    before do
      @object_page.wait_for_element_and_type(@object_page.taxon_date_input(0), '5580-5460 BC')
      @object_page.hit_enter
    end

    it 'generates the corresponding earliest and latest years' do
      @object_page.wait_until(1) { !@object_page.element_value(@object_page.date_earliest_year).empty? }
      expect(@object_page.element_value @object_page.date_earliest_year).to eql('5580')
      expect(@object_page.element_value @object_page.date_earliest_month).to eql('1')
      expect(@object_page.element_value @object_page.date_earliest_day).to eql('1')
      expect(@object_page.element_value @object_page.date_earliest_era).to eql('BCE')
      expect(@object_page.element_value @object_page.date_latest_year).to eql('5460')
      expect(@object_page.element_value @object_page.date_latest_month).to eql('12')
      expect(@object_page.element_value @object_page.date_latest_day).to eql('31')
      expect(@object_page.element_value @object_page.date_latest_era).to eql('BCE')
    end
  end

  context 'when "5,580-5,460 BC" is entered' do
    before do
      @object_page.wait_for_element_and_type(@object_page.taxon_date_input(0), '5,580-5,460 BC')
      @object_page.hit_enter
    end

    it 'generates the corresponding earliest and latest years' do
      @object_page.wait_until(1) { !@object_page.element_value(@object_page.date_earliest_year).empty? }
      expect(@object_page.element_value @object_page.date_earliest_year).to eql('5580')
      expect(@object_page.element_value @object_page.date_earliest_month).to eql('1')
      expect(@object_page.element_value @object_page.date_earliest_day).to eql('1')
      expect(@object_page.element_value @object_page.date_earliest_era).to eql('BCE')
      expect(@object_page.element_value @object_page.date_latest_year).to eql('5460')
      expect(@object_page.element_value @object_page.date_latest_month).to eql('12')
      expect(@object_page.element_value @object_page.date_latest_day).to eql('31')
      expect(@object_page.element_value @object_page.date_latest_era).to eql('BCE')
    end
  end

  context 'when "5580 - 5460 BC" is entered' do
    before do
      @object_page.wait_for_element_and_type(@object_page.taxon_date_input(0), '5580 - 5460 BC')
      @object_page.hit_enter
    end

    it 'generates the corresponding earliest and latest years' do
      @object_page.wait_until(1) { !@object_page.element_value(@object_page.date_earliest_year).empty? }
      expect(@object_page.element_value @object_page.date_earliest_year).to eql('5580')
      expect(@object_page.element_value @object_page.date_earliest_month).to eql('1')
      expect(@object_page.element_value @object_page.date_earliest_day).to eql('1')
      expect(@object_page.element_value @object_page.date_earliest_era).to eql('BCE')
      expect(@object_page.element_value @object_page.date_latest_year).to eql('5460')
      expect(@object_page.element_value @object_page.date_latest_month).to eql('12')
      expect(@object_page.element_value @object_page.date_latest_day).to eql('31')
      expect(@object_page.element_value @object_page.date_latest_era).to eql('BCE')
    end
  end

  context 'when "5,580 - 5,460 BC" is entered' do
    before do
      @object_page.wait_for_element_and_type(@object_page.taxon_date_input(0), '5,580 - 5,460 BC')
      @object_page.hit_enter
    end

    it 'generates the corresponding earliest and latest years' do
      @object_page.wait_until(1) { !@object_page.element_value(@object_page.date_earliest_year).empty? }
      expect(@object_page.element_value @object_page.date_earliest_year).to eql('5580')
      expect(@object_page.element_value @object_page.date_earliest_month).to eql('1')
      expect(@object_page.element_value @object_page.date_earliest_day).to eql('1')
      expect(@object_page.element_value @object_page.date_earliest_era).to eql('BCE')
      expect(@object_page.element_value @object_page.date_latest_year).to eql('5460')
      expect(@object_page.element_value @object_page.date_latest_month).to eql('12')
      expect(@object_page.element_value @object_page.date_latest_day).to eql('31')
      expect(@object_page.element_value @object_page.date_latest_era).to eql('BCE')
    end
  end

  context 'when "5460-5580 BC" is entered' do
    before do
      @object_page.wait_for_element_and_type(@object_page.taxon_date_input(0), '5460-5580 BC')
      @object_page.hit_enter
    end

    it 'generates the corresponding earliest and latest years' do
      @object_page.wait_until(1) { !@object_page.element_value(@object_page.date_earliest_year).empty? }
      expect(@object_page.element_value @object_page.date_earliest_year).to eql('5580')
      expect(@object_page.element_value @object_page.date_earliest_month).to eql('1')
      expect(@object_page.element_value @object_page.date_earliest_day).to eql('1')
      expect(@object_page.element_value @object_page.date_earliest_era).to eql('BCE')
      expect(@object_page.element_value @object_page.date_latest_year).to eql('5460')
      expect(@object_page.element_value @object_page.date_latest_month).to eql('12')
      expect(@object_page.element_value @object_page.date_latest_day).to eql('31')
      expect(@object_page.element_value @object_page.date_latest_era).to eql('BCE')
    end
  end
end
