class CreateCaseStudies < ActiveRecord::Migration
  def change
    create_table :case_studies do |t|

      t.string  :name
      t.string  :main_image
      t.text    :url
      t.text    :overview
      t.text    :resource
      t.text    :problem
      t.text    :process
      t.text    :process
      t.text    :outcome

      t.integer :development_cycle
      t.integer :design_phase
      t.integer :project_domain
      t.integer :customer_type
      t.integer :user_age
      t.integer :privacy_level
      t.integer :social_setting

      t.boolean :customer_is_user
      t.boolean :remote_project

      t.integer :num_of_designers
      t.integer :num_of_users

      t.integer :time_period
      t.text    :time_unit

      t.integer :company_id

      t.timestamps
    end
  end
end