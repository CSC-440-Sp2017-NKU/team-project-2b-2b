class AddSolvedToQuestions < ActiveRecord::Migration[5.0]
  def change
    add_column :questions, :solved, :integer, default: 0
  end
end
