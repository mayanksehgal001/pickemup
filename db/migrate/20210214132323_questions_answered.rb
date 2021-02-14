class QuestionsAnswered < ActiveRecord::Migration[6.0]
  def change
    create_table :answered_questions, id: :uuid do |t|
      t.references :user, type: :uuid
      t.references :question, type: :uuid
      t.integer   :selected_choice, null: false
      t.boolean :correct

      t.timestamps
    end
  end
end
