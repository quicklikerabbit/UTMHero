class AddCreatedByToLinks < ActiveRecord::Migration
  def change
    add_column :links, :created_by, :string
  end
end
