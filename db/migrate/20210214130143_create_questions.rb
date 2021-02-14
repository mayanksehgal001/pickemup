class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions, id: :uuid do |t|
      t.text :description, null: false
      t.string :choice1, null: false
      t.string :choice2, null: false
      t.integer :correct_choice, null: false

      t.timestamps
    end
  end
end
