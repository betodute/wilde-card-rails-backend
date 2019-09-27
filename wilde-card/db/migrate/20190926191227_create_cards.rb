class CreateCards < ActiveRecord::Migration[5.2]
  def change
    create_table :cards do |t|
      t.string :title
      t.string :subtitle
      t.string :note
      t.string :snippet
      t.string :villanelle
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end
