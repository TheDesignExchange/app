class AddCaseStudyRefToMethodCollection < ActiveRecord::Migration
  def change
    add_reference :method_collections, :case_study, index: true
  end
end
