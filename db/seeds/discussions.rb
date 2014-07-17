require "json"

p " Starting Discussions Seed"

p "Adding users"
users_file = Rails.root.join('public', 'users.json');
data_users = JSON.parse( IO.read(users_file) )

p "Adding discussions"
discussion_file = Rails.root.join('public', 'discussions.json');
data_discussions = JSON.parse( IO.read(discussion_file) )

save_attempts_users = []
data_users.each do |raw|

	u = User.new(raw)
	p u.email

	save_attempts_users.push(u.save)
	p save_attempts_users.last 
end

save_attempts_discussions = []
data_discussions.each do |raw|

	raw["user_id"] = User.where(email: raw["user_id"]).first.id

	d = Discussion.new(raw)
	p  "Added discussion: #{d.name}" unless not d.save
	p d.errors unless d.save

	save_attempts_discussions.push(d.save)

end

p "Disussions Seed was Able to Finish"
p save_attempts_users.count(true).to_s+" out of: "+save_attempts_users.length.to_s+" were saved correctly."
p save_attempts_discussions.count(true).to_s+" out of: "+save_attempts_discussions.length.to_s+" were saved correctly."