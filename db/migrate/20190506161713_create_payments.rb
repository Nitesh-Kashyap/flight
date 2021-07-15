class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
      t.string :name
      t.integer :card_number
      t.integer :cvv
      t.integer :month
      t.integer :year

      t.timestamps
    end
  end
end
