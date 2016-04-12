class CreateAdImages < ActiveRecord::Migration
  def change
    create_table :ad_images do |t|
      t.references :link, index: true
      t.string :image_url

      t.timestamps
    end
  end
end
