require "json"

discussion_file = 'discussions.json'

# File should be in public
def get_data_discussion(json_file)
	file = Rails.root.join('public', json_file);
	data_discussions = JSON.parse(IO.read(file))
end


def process_discussions(data)
	Discussion.destroy_all
	p "===============  SEEDING DISCUSSIONS  ================"
	data.each do |el|
		el["user_id"] = User.where(email: el["user_id"]).first.id
		disc = Discussion.new(el)
		p "Added discussion: #{disc.title}" unless not disc.save 
		# p disc.errors unless disc.save
	end
	p "==============================="
end

data_discussions = get_data_discussion(discussion_file)
process_discussions(data_discussions)