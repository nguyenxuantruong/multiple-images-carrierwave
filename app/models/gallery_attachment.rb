class GalleryAttachment < ActiveRecord::Base
	belongs_to :gallery
	mount_uploader :image, ImageUploader
end
