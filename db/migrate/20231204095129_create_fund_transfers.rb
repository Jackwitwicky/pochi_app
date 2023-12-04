class CreateFundTransfers < ActiveRecord::Migration[7.1]
  def change
    create_table :fund_transfers do |t|
      t.integer :from, null: false
      t.integer :to, null: false
      t.decimal :amount, null: false, precision: 10, scale: 2

      t.timestamps
    end
  end
end
