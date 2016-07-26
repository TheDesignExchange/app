# == Schema Information
#
# Table name: collections
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  is_private :boolean
#  overview   :text
#  owner_id   :integer
#

require 'rails_helper'

RSpec.describe Collection, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
