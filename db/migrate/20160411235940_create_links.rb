class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.text :link_reference
      t.string :communication_id
      t.string :campaign_medium
      t.string :campaign_source
      t.string :campaign_name
      t.string :utm_content
      t.string :short_link
      t.string :website_url
      t.references :client, index: true

      t.timestamps
    end
  end
end
