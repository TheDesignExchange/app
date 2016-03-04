# == Schema Information
#
# Table name: design_methods
#
#  id                 :integer          not null, primary key
#  name               :string(255)      not null
#  overview           :text             not null
#  process            :text             not null
#  aka                :string(255)
#  owner_id           :integer          not null
#  created_at         :datetime
#  updated_at         :datetime
#  num_of_designers   :integer          default(1)
#  num_of_users       :integer          default(1)
#  time_period        :integer          default(0)
#  time_unit          :string(255)      default("")
#  main_image         :string(255)
#  likes              :integer          default(0)
#  synonyms           :text
#  benefits           :text
#  limitations        :text
#  skills             :text
#  usage              :text
#  online_resources   :text
#  history            :text
#  critiques          :text
#  additional_reading :text
#

require 'test_helper'

class DesignMethodTest < ActiveSupport::TestCase 
	setup do 
		@design_method = design_methods(:DarkHorse)
	end 

	test "should be valid" do
		assert @design_method.valid?
	end

	test "name should be present" do
		@design_method.name = "  "
		assert_not @design_method.valid?
	end

	test "overview should be present" do
		@design_method.overview = "   "
		assert_not @design_method.valid?
	end

	test "process should be present" do
		@design_method.process = "   "
		assert_not @design_method.valid?
	end

	test "owner_id should be present" do
		@design_method.owner_id = "    "
		assert_not @design_method.valid?
	end

end 
