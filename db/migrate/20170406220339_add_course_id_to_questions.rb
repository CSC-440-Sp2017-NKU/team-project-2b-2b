class AddCourseIdToQuestions < ActiveRecord::Migration[5.0]
  def change
    add_column :questions, :course_id, :integer
  end
end
