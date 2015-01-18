require 'spreadsheet'

# Set admin as creator of methods
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

# These indices are set to the current spreadsheet format. Update as necessary
CHARACTERISTIC_INDEX = 8
METHOD_INDEX = 2
CHAR_ROW = 1
METHOD_ROW = 3
VARIATION_INDEX = 7

# Create variation relations between methods
#
# === Parameters
# - sheet: the method card spreadsheet being used
#
# === Variables
# - variation: the variant design method
# - parent_method: the parent design method

def load_variations(sheet)
  sheet.each METHOD_ROW do |row|
    parents = row[VARIATION_INDEX].to_s.strip
    if parents.empty?
      next
    else
      variant_name = row[METHOD_INDEX].to_s.strip
      variation = DesignMethod.where(name: variant_name).first

      parents.split(/, */).each do |parent|
        parent_method = DesignMethod.where(name: parent).first
        if variation && parent_method
          parent_method.variations << variation
          p "    Added: #{variant_name} is variation of #{parent}"
        end
      end
    end
  end
end

# Load design methods from the method card spreadsheets. This includes meta fields, citations, and characteristics
#
# === Parameters
# - category: the method category the methods fall under
# - sheet: the method card spreadsheet being used
# - admin: the admin user creating the methods
#
# === Variables
# - design_method: the design method being created
# - fields: used to hold the fields needed to create a method

def load_methods(category, sheet, admin)

  p "========================= LOAD DESIGN METHODS ========================="

  #Load in design method fields
  fields = Hash.new
  sheet.each METHOD_ROW do |row|
    name = row[METHOD_INDEX].to_s.strip

    if name.empty?
      break
    elsif DesignMethod.exists?(name: name)
      design_method = DesignMethod.where(name: name).first
    else
      fields[:name] = name
      fields[:overview] = row[METHOD_INDEX + 1].to_s.strip
      fields[:process] = "default"
      aka = row[METHOD_INDEX + 2].to_s.strip
      image = row[METHOD_INDEX + 3].to_s.strip

      design_method = DesignMethod.new(fields)
      design_method.owner = admin
      design_method.aka = aka
      design_method.main_image = image

      if !design_method.save
        p "Error while creating a design method: #{fields[:name]} "
        design_method.errors.full_messages.each do |message|
          p "\t#{message}"
        end
        next
      end
    end

    p "Added #{design_method.name}"
  
    #Load in characteristics 
    j = CHARACTERISTIC_INDEX
    characteristics = row[j]
    group_row = sheet.row(CHAR_ROW)

    while characteristics != nil
      group_name = group_row[j].to_s.strip
      group = CharacteristicGroup.where(name: group_name).first_or_create!
      if group
        category.characteristic_groups << group
      end
      
      characteristics.split(/, *\n*/).each do |char_name|
        if !char_name.blank?
          characteristic = Characteristic.where({name: char_name, characteristic_group_id: group.id}).first_or_create!
          if characteristic && !design_method.characteristics.include?(characteristic)
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
      citations.split(/, *\n/).each do |cit|
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
end

# Create five basic method categories
p "====================== SEEDING METHOD CATEGORIES ======================="

building = MethodCategory.new
building.name = "Building and Prototyping"

analysis = MethodCategory.new
analysis.name = "Analysis and Synthesis"

ideation = MethodCategory.new
ideation.name = "Ideation"

data = MethodCategory.new
data.name = "Data Gathering"

communication = MethodCategory.new
communication.name = "Communication"

categories = [building, analysis, ideation, data, communication]
sheets = {"Building and Prototyping" => "Building_Prototyping_Cards.xls",
          "Analysis and Synthesis" => "Analysis_Synthesis_Cards.xls",
          "Ideation" => "Ideation_Cards.xls",
          "Data Gathering" => "Data_Gathering_Cards.xls",
          "Communication" => "Communication_Cards.xls"}

categories.each do |cat|
  p "========================== Category #{cat.name} created! ======================================" if cat.save
  p cat.errors unless cat.save
  name = "lib/tasks/data/#{sheets[cat.name]}"
  filename = File.join(Rails.root, name)
  sheet = Spreadsheet.open(filename).worksheet 0

  load_methods(cat, sheet, admin)
  load_variations(sheet)
end





