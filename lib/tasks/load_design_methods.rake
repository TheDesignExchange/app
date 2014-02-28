namespace :methods do

  namespace :categories do

    desc "Scan for categories"
    task :scan => :environment do
      filename = File.join(Rails.root, 'lib/tasks/data/design_methods.xls')

      data = Spreadsheet.open(filename).worksheet 0

      categories = Hash.new

      data.each do |row|
        string = row[6]

        if string and !string.include?('http') and !string.include?('pg')
          string.downcase.split(/[\n,]/).each do |cat|
            if !cat.blank?
              cat = cat.strip
              categories[cat] = categories[cat] ? categories[cat]+1 : 1
            end
          end
        end
      end

      categories.map {|name, count| name}.sort.each {|name| p name}
    end

    desc "Normalize categories and count"
    task normalize: :environment do
      keys = [
        "analy",
        "build",
        "commu",
        "evalu",
        "gathe",
        "gener",
      ]

      filename = File.join(Rails.root, 'lib/tasks/data/design_methods.xls')

      data = Spreadsheet.open(filename).worksheet 0

      categories = Hash.new

      data.each do |row|
        string = row[6]

        if string and !string.include?('http') and !string.include?('pg')
          string.downcase.split(/[\n,]/).each do |cat|
            if !cat.blank?
              cat = cat.strip
              keys.each do |key|
                if cat.include?(key)
                  categories[key] = categories[key] ? categories[key]+1 : 1
                end
              end
            end
          end
        end
      end

      p categories

    end
  end
end
