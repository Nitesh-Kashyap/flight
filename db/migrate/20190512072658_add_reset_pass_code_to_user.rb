class AddResetPassCodeToUser < ActiveRecord::Migration[5.2]
  def change
  	add_column :users, :reset_pass_code, :string
  end
end
