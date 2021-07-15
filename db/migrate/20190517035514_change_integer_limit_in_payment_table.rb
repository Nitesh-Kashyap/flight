class ChangeIntegerLimitInPaymentTable < ActiveRecord::Migration[5.2]
  def change
  	change_column :payments, :card_number, :integer, limit: 8
  end
end
