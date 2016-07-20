class AddColumsToUserAdder < ActiveRecord::Migration
  def change
    add_column :user_adders, :client, :string
    add_column :user_adders, :user_email, :string
  end
end
