class AddDeptToCourses < ActiveRecord::Migration[5.0]
  def change
    add_column :courses, :dept, :string
  end
end
