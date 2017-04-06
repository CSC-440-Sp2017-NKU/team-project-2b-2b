class CreateCourses < ActiveRecord::Migration[5.0]
  def change
    create_table :courses do |t|
      t.string :prefix
      t.integer :number
      t.string :title

      t.timestamps
    end
  end
end
