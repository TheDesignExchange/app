# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  def favorite(design_method)
    if !self.favorite_methods.exists?(design_method)
      self.favorite_methods << design_method
    end
  end

  def commented_methods
    method_list = Array.new
    comments = Comment.find_comments_by_user(self)
    comments.each do |c|
      method = Comment.find_commentable(c.commentable_type, c.commentable_id)
      if method
        method_list << method
      end
    end
  end
  has_many :owned_methods, dependent: :destroy, class_name: "DesignMethod", foreign_key: :owner_id
  has_many :method_favorites, dependent: :destroy
  has_many :favorite_methods, through: :method_favorites, :source => :design_method
end
