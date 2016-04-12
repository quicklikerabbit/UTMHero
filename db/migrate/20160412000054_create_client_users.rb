class CreateClientUsers < ActiveRecord::Migration
  def change
    create_table :client_users do |t|
      t.references :client, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
