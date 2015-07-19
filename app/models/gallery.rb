class Gallery < ActiveRecord::Base
	has_many :gallery_attachments
	accepts_nested_attributes_for :gallery_attachments
end
