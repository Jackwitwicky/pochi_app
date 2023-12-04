class CreateNotifications < ActiveRecord::Migration[7.1]
  def change
    create_table :notifications do |t|
      t.string :title, null: false
      t.string :message, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
