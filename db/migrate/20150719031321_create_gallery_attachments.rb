class CreateGalleryAttachments < ActiveRecord::Migration
  def change
    create_table :gallery_attachments do |t|
      t.integer :gallery_id
      t.string :image

      t.timestamps null: false
    end
  end
end
