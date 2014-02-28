
# Reset users

User.destroy_all

# Create default admin user

admin = User.create!(
  email: "admin@thedesignexchange.org",
  password: "thedesignexchange",
  password_confirmation: "thedesignexchange",
)

# Read in design methods from the spreadsheet

filename = File.join(Rails.root, 'lib/tasks/data/design_methods.xls')
fields = Hash.new

DesignMethod.destroy_all

data = Spreadsheet.open(filename).worksheet 0

keys = {
  analy: "Analyzing and Synthesizing Information",
  build: "Building Prototypes and Mock-ups",
  commu: "Communicating Within and Across Teams",
  evalu: "Evaluating and Choosing",
  gathe: "Gathering Information",
  gener: "Generating Ideas and Concepts",
}
categories = Hash.new

data.each do |row|
  fields[:name]      = row[1].to_s.strip
  fields[:overview]  = row[2].to_s.strip
  fields[:process]   = row[3].to_s.strip
  fields[:principle] = row[4].to_s.strip

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

  # Read in categories

  string = row[6]

  if string and !string.include?('http') and !string.include?('pg')
    string.downcase.split(/[\n,]/).each do |cat|  # split by new line character
      if !cat.blank?
        cat = cat.strip
        keys.each do |key, title|
          if cat.include?(key.to_s)
            category = MethodCategory.where(name: title).first_or_create!
            if !design_method.method_categories.include?(category)
              design_method.method_categories << category
            end
            p "#{design_method.name}: #{design_method.method_categories.map {|c| c.name}}"
          end
        end
      end
    end
  end

  citation = row[5]
  if citation
    citation.split(/[\n\*]/).each do |cit|
      if !cit.blank?
        to_add = Citation.where(text: cit).first_or_create!
        if !design_method.citations.include?(to_add)
          design_method.citations << to_add
        end
        p "#{design_method.name}: #{design_method.citations.map {|c| c.text}}"
      end
    end
  end
end

header = DesignMethod.where(name: "Name").first
header.destroy if header

header = Citation.where(text: "Name").first
header.destroy if header

