# == Schema Information
#
# Table name: resources
#
#  id                :integer          not null, primary key
#  name              :string(255)      default("")
#  permission_to_use :boolean          default(FALSE)
#  type              :string(255)      default("")
#  company_id        :integer
#  created_at        :datetime
#  updated_at        :datetime
#

class Resource < ActiveRecord::Base
end
