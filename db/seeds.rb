# full seed: loads users, design methods, case studies and discussions

require "json"
require 'spreadsheet'

# Seeding Users
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

# Seeding Design Methods
p "============================= SEEDING DESIGN METHODS ======================================"

# Create default admin user
admin = User.where(username: "admin").first

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
  p "============================ Category #{cat.name} created! ======================================" if cat.save
  p cat.errors unless cat.save
  name = "lib/tasks/data/#{sheets[cat.name]}"
  filename = File.join(Rails.root, name)
  sheet = Spreadsheet.open(filename).worksheet 0

  load_methods(cat, sheet, admin)
  load_variations(sheet)
end

# Seeding Case Studies

case_study_file = 'casestudies.json'

# File should be in public
def get_data(json_file)
  file = Rails.root.join('public', json_file);
  data = JSON.parse( IO.read(file) )
end

def process_companies(data)
  Company.destroy_all
  p "===============  SEEDING COMPANIES  ================"
  data.each do |el|
    el["projectDomain"] ||= "design"
    temp_email = "#{el['companyName'].gsub(' ','').downcase.gsub('&', '')}@unknown.com"
    comp = Company.new({:name => el["companyName"], :domain => el["projectDomain"], :email => temp_email })
    p "Added company: #{comp.name}" unless not comp.save 
    # p comp.errors unless comp.save
  end
  p "==============================="
end
def process_contacts(data)
  
  p "===============  SEEDING CONTACT  ================"
  Contact.destroy_all
  data.each do |el|
      if el["authorName"]
      id = Company.where("name = ?", el["companyName"]).first.id
      ct = Contact.new({:name => el["authorName"].split(',')[0], :email => el["authorEmail"], :company_id => id})
      p "Added contact: #{ct.name}" unless not ct.save
      # p ct.errors unless ct.save
    end 
  end
  
  p "==============================="
end
def process_casestudies(data)
  CaseStudy.destroy_all
  p "===============  SEEDING CASE STUDIES  ================"
  data.each do |el|
    el.each{|k, v| el[k] = v.strip }
    comp = Company.where("name = ?", el["companyName"]).first
    el.delete("companyName")
    el.delete("projectDomain")
    el.delete("authorName")
    el.delete("authorEmail")
    el.delete("authorOther")
    el.delete("methods")
    
    c = CaseStudy.new(el)
    c.company = comp
    p "Added casestudy: #{c.title}" unless not c.save
    p c.errors unless c.save
    
  end
  p "==============================="
end

def clean_raw_data(data)
  data.each do |raw|
    @@deletions.each do |d|
      d.each do |el|
        raw.delete(el)
      end
    end
  end
  data
end


file_attributes = ["permissionToUse", "name", "type"]
author_attributes = ["authorName", "authorEmail", "authorOther"]
company_attributes = ["contact"]
model_attribtues = ["developmentCycle", "designPhase", "customerType", "userAge", "privacyLevel", "socialSetting"]
other = ["companyID", "subTitle", "imageResource", "PDFResource"]
@@deletions = [other, file_attributes, company_attributes, model_attribtues]

data = get_data(case_study_file)
clean_data = clean_raw_data(data)
process_companies(clean_data)
process_contacts(data)
process_casestudies(data)

# Seeding Discussions

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

  

  
    
  



  
  
  








