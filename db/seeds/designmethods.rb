filename = File.join(Rails.root, 'lib/tasks/data/dx.owl')
fields = Hash.new

DesignMethod.destroy_all
MethodCategory.destroy_all
Citation.destroy_all

data = RDF::Graph.load(filename)

# SPARQL prefix
root_prefix = "PREFIX : <http://www.semanticweb.org/howard/ontologies/2014/0/DesignExchange_Methods#>"

# Searching for design methods and method categories, using the subClassOf relationship.
# This should be fixed w/something more convenient -- have some kind of predicate I can search on.
# Hm, based on how this looks, might need to add descriptions to the method categories as well.

methods = SPARQL.parse("SELECT ?subj ?obj { ?subj <#{RDF::RDFS.subClassOf}> ?obj }")
all_objects = Set.new
all_subjects = Set.new

data.query(methods).each do |results|
  all_objects << results.obj.to_s.split('#')[1]
  all_subjects << results.subj.to_s.split('#')[1]
end

# Deleting entries with punctuation that's troublesome for SPARQL queries
all_objects.delete_if { |str| str == nil || str.match(/,|\(|\)|\\|\//) }
all_subjects.delete_if { |str| str == nil || str.match(/,|\(|\)|\\|\//) }

# The design methods are the individuals (no subclasses) - right now this over-selects
only_methods = all_subjects - all_objects
p only_methods

# The method categories are everything else - right now this under-selects
method_categories = all_objects - only_methods
p method_categories

# # Instantiating method categories
# method_categories.each do |cat|
#   method_category = MethodCategory.new(name: cat)
#   if method_category.save
#     p "Added method category: #{method_category.name}"
#   else
#     p "Error while creating a method category: "
#     method_category.errors.full_messages.each do |message|
#       p "\t#{message}"
#     end
#   end
# end

# method_categories.each do |cat|
#   # Load in children of method category
#   method_category = MethodCategory.where(name: cat).first
#   children = SPARQL.parse("#{root_prefix} SELECT ?child { ?child <#{RDF::RDFS.subClassOf}> :#{cat} }")
#   data.query(children).each do |results|
#     child_name = results.child.to_s.split('#')[1]
#     if method_category.add_child(MethodCategory.where(name: child_name).first)
#       p "Added child of #{cat}: #{child_name}"
#     end
#   end
# end

# def remove_unwanted(method)
#   method.children.each do |child|
#     name = child.name
#     child.destroy
#     p "    Removed #{name}"
#   end
#   m_name = method.name
#   method.destroy
#   p "    Removed #{m_name}"
# end

# # Remove any of the classes that don't fall under the Method umbrella. If property paths gets added to the SPARQL gem then this won't be necessary
# to_delete = MethodCategory.where(name: "Person").first
# remove_unwanted(to_delete)
# to_delete = MethodCategory.where(name: "Method_Characteristics").first
# remove_unwanted(to_delete)
# to_delete = MethodCategory.where(name: "Processes").first
# remove_unwanted(to_delete)
# to_delete = MethodCategory.where(name: "Skills").first
# remove_unwanted(to_delete)


# Instantiating design methods; currently filling in contents w/ "default" so that things can get loaded.
# Fix this once more of the ontology is ready, and we want to catch entries that need to get fixed.
only_methods.each do |method|
  fields[:name] = method
  fields[:overview] = "default"
  fields[:process] = "default"
  fields[:principle] = "default"

  # Add the overview: currently searching on AnnotationProperty Description
  overview = SPARQL.parse("#{root_prefix} SELECT ?overview { :#{method} :Description ?overview }")
  data.query(overview).each do |results|
    fields[:overview] = results.overview.to_s
  end

  # Add the process: currently searching on AnnotationProperty process
  process = SPARQL.parse("#{root_prefix} SELECT ?process { :#{method} :process ?process }")
  data.query(process).each do |results|
    fields[:process] = results.process.to_s
  end

  # Add the principle: currently searching on AnnotationProperty Notes
  principle = SPARQL.parse("#{root_prefix} SELECT ?principle { :#{method} :Notes ?principle }")
  data.query(principle).each do |results|
    fields[:principle] = results.principle.to_s
  end

  design_method = DesignMethod.new(fields)
  design_method.owner = User.where("username == ?", "admin").first
  design_method.principle = ""

  if !design_method.save
    p "Error while creating a design method: "
    design_method.errors.full_messages.each do |message|
      p "\t#{message}"
    end
  else
    p "Added design method: #{design_method.name}"
  end

  # # Read in categories
  # categories = SPARQL.parse("#{root_prefix} SELECT ?obj { :#{design_method.name} <#{RDF::RDFS.subClassOf}> ?obj }")
  # data.query(categories).each do |results|
  #   cat_name = results.obj.to_s.split('#')[1]
  #   if cat_name
  #     category = MethodCategory.where(name: cat_name).first
  #     if category && !design_method.method_categories.include?(category)
  #       design_method.method_categories << category
  #       p "    Added category #{cat_name}"
  #       category.parents.each do |gparents|
  #         if gparents && !design_method.method_categories.include?(gparents)
  #           design_method.method_categories << gparents
  #           p "    Added category #{gparents.name}"
  #         end
  #       end
  #     end
  #   end
  # end

  # # Read in citations
  # citations = SPARQL.parse("#{root_prefix} SELECT ?ref { :#{design_method.name} :references ?ref }")
  # data.query(citations).each do |results|
  #   cit_text = results.ref.to_s
  #   citation = Citation.where(text: cit_text).first_or_create!
  #   if !design_method.citations.include?(citation)
  #     design_method.citations << citation
  #     p "    Added citation #{cit_text}"
  #   end
  # end
end