require "json"

users_file = 'users.json'

# File should be in public
def get_data_user(json_file)
	file = Rails.root.join('public', json_file);
	data_users = JSON.parse(IO.read(file))
end

def process_users(data)
	# User.destroy_all
	p "===============  SEEDING USERS  ================"
	data.each do |el|
		user = User.new(el)
		p "Added user: #{user.email}" unless not user.save 
		# p user.errors unless user.save
	end
	p "==============================="
end

data_users = get_data_user(users_file)
process_users(data_users)