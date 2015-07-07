require 'representable/yaml'
require 'hash_control'
require 'yaml'

class Comment
  include ::HashControl::Model
  require_key :author, :body, :date
  permit_key :image
end
comment = Comment.new(author: 'me', body: 'interesting stuff', date: Time.now)

puts comment.author
puts comment.body
puts comment.date.class
puts comment.image

class User
  include ::HashControl::Model
  require_key :name, :age
  permit_key :image
end
user = User.new(name: "hi", age: "over 18")

puts user.name
puts user.age

# module UserRepresenter
#   include Representable::YAML

#   collection :hash, :style => :flow

#   def hash
#     [name, age]
#   end
# end

# user.extend(UserRepresenter).to_yaml
# #=> ---
# # hash: [Andrew, over 18]
