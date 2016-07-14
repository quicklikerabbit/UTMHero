class CreateUserAdders < ActiveRecord::Migration
  def change
    create_table :user_adders do |t|

      t.timestamps
    end
  end
end
