class AddCompletionScoreToDesignMethods < ActiveRecord::Migration
  def change
    add_column :design_methods, :completion_score, :integer
  end
end
