class CreateWalletTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :wallet_transactions do |t|
      t.decimal :amount, null: false, precision: 10, scale: 2
      t.integer :transaction_type, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
