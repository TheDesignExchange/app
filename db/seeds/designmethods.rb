require 'spreadsheet'

p "-------------- RESET ------------------"
User.destroy_all
DesignMethod.destroy_all
MethodCategory.destroy_all
CharacteristicGroup.destroy_all
Characteristic.destroy_all

# Create default admin user
admin = User.new(
  username: "admin",
  first_name: "TheDesignExchange",
  last_name: "Admin",
  email: "admin@thedesignexchange.org",
  password: "thedesignexchange",
  password_confirmation: "thedesignexchange",
)

p "Admin #{admin.username} created!" if admin.save
p admin.errors unless admin.save

# Create five basic method categories
p "====================== SEEDING METHOD CATEGORIES ======================="

# Currently only building category is ready. Modify as necessary once
# the taxonomy team is finished.

building = MethodCategory.new
building.name = "Building and Prototyping"

p "Category #{building.name} created!" if building.save
p building.errors unless building.save

# These indices are set to the current spreadsheet format. Update as necessary
CHARACTERISTIC_INDEX = 6
METHOD_INDEX = 1

filename = File.join(Rails.root, "lib/tasks/data/building.xls")
sheet = Spreadsheet.open(filename).worksheet 0
category = building

p "============================= LOAD GROUPS  =========================="
i = CHARACTERISTIC_INDEX
group_list = sheet.row(0)
char_list = sheet.row(1)
group_name = group_list[i]

group_index = Hash.new

while group_name != nil
  g_name = group_name.to_s.strip
  group = CharacteristicGroup.new
  group.name = g_name
  if group.save
    category.characteristic_groups << group
    group_index[i] = group
    p "Added #{group.name}!"
  end

  i += 1
  group_name = group_list[i]
end

p "========================= LOAD DESIGN METHODS ========================="

#Load in design methods
fields = Hash.new
sheet.each 3 do |row|
  fields[:name] = row[METHOD_INDEX].to_s.strip
  fields[:overview] = row[METHOD_INDEX + 1].to_s.strip
  fields[:process] = "default"
  fields[:aka] = row[METHOD_INDEX + 2].to_s.strip.capitalize
  fields[:main_image] = row[METHOD_INDEX + 3].to_s.strip

  design_method = DesignMethod.new(fields)
  design_method.owner = admin
  if !design_method.save
    p "Error while creating a design method: "
    design_method.errors.full_messages.each do |message|
      p "\t#{message}"
    end
  else
    p "Added #{design_method.name}"
  end

  #Load in characteristics 
  j = CHARACTERISTIC_INDEX
  characteristics = row[j]

  while characteristics != nil
    group = group_index[j]
    characteristics.split(/[\n\*]/).each do |char_name|
      if !char_name.blank?
        characteristic = Characteristic.where({name: char_name, characteristic_group_id: group.id}).first_or_create!
        if !design_method.characteristics.include?(characteristic)
          design_method.characteristics << characteristic
          p "    Added #{characteristic.name}"
        end
      end
    end

    j += 1
    characteristics = row[j]
  end

  #Load in citations
  citations = row[METHOD_INDEX + 4]
  if citations
    citations.split(/[\n\*]/).each do |cit|
      if !cit.blank?
      citation = Citation.where(text: cit).first_or_create!
        if !design_method.citations.include?(citation)
          design_method.citations << citation
          p "    Added #{citation.text}"
        end
      end
    end
  end
end
