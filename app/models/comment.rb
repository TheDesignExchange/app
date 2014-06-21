class Comment < ActiveRecord::Base
  validates :text, :user, :design_method, presence: true

  #TODO: finish reply to make flat table hierarchy
  def reply(comment)
    if Comment.exists?(comment)
      self.replies << comment
    end
  end

  belongs_to :user
  belongs_to :design_method

  has_many :replies, class_name: "Comment", foreign_key: :parent_id
  belongs_to :parent, class_name: "Comment"
end
