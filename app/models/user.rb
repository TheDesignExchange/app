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
#  first_name             :string(255)
#  last_name              :string(255)
#  username               :string(255)
#  profile_picture        :string(255)
#  phone_number           :string(255)
#  website                :string(255)
#  facebook               :string(255)
#  twitter                :string(255)
#  linkedin               :string(255)
#  about_text             :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#

class User < ActiveRecord::Base
  mount_uploader :profile_picture, PictureUploader
   attr_accessible :email, :first_name, :last_name, :username, :phone_number, :website, 
   :facebook, :twitter, :linkedin, :about_text , :profile_picture, :password, :password_confirmation
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
          validates :username, presence: true, uniqueness: true
          validates :first_name, presence: true
          validates :last_name, presence: true


  def favorite(design_method)
    if !self.favorite_methods.exists?(design_method)
      self.favorite_methods << design_method
    end
  end

  def liked?(design_method)
    method_like = MethodLike.where(
      user_id: self.id,
      design_method_id: design_method.id
    ).take

    if method_like
      return true
    else
      return false
    end
  end

  def like(design_method)
    method_like = MethodLike.where(
      user_id: self.id,
      design_method_id: design_method.id
    ).first_or_initialize

    if method_like.new_record? and method_like.save
      return method_like
    else
      return false
    end
  end

  def unlike(design_method)
    method_like = MethodLike.where(
      user_id: self.id,
      design_method_id: design_method.id
    ).take

    if method_like
      method_like.destroy
      return method_like
    else
      return false
    end
  end


  has_many :owned_methods, dependent: :destroy, class_name: "DesignMethod", foreign_key: :owner_id
  has_many :method_favorites, dependent: :destroy
  has_many :favorite_methods, through: :method_favorites, :source => :design_method
  has_many :owned_discussions, dependent: :destroy, class_name: "Discussion", foreign_key: :user_id
  has_many :comments, dependent: :destroy
  has_many :tags
end
