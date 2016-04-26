class AddUtmLinkToLinks < ActiveRecord::Migration
  def change
    add_column :links, :utm_link, :string
  end
end
