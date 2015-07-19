# Upload Multiple Images With carrierwave gem
## Environment:
* Ruby version: 2.1.0
* Rails version: 4.2.1
* Database: sqlite3

## System dependencies:
* imagemagick

## Deployment instructions
### Generater initial code
```
rails new project_name
```
**Add some gems**
```
gem 'carrierwave'
gem 'rmagick', '~> 2.15.2'
```
**And run bundle command**
```
bundle install
```
**loading CarrierWave after loading your ORM**

*#config/environment.rb*
```
require 'carrierwave/orm/activerecord'
```

**Config uploader**
```
include CarrierWave::RMagick
...
version :thumb do
  process :resize_to_fit => [200, 200]
end
```

### To do just follow these steps.
```
rails scaffold Gallery name:string
rails generate uploader Image
rails scaffold GalleryAttachment gallery_id:integer image:string
```

**In gallery.rb**
```
class Gallery < ActiveRecord::Base
	has_many :gallery_attachments
	accepts_nested_attributes_for :gallery_attachments
end
```

**In gallery_attachment.rb**
```
class GalleryAttachment < ActiveRecord::Base
	belongs_to :gallery
	mount_uploader :image, ImageUploader
end
```

**gallery_controller.rb**
```
def new
  @gallery = Gallery.new
  @gallery_attachment = @gallery.gallery_attachments.build
end

# POST /galleries
# POST /galleries.json
def create
  @gallery = Gallery.new(gallery_params)

  respond_to do |format|
    if @gallery.save
      params[:gallery_attachments]['image'].each do |image|
        @gallery_attachment = @gallery.gallery_attachments.create!(:image => image)
      end
      format.html { redirect_to @gallery, notice: 'Gallery was successfully created.' }
      format.json { render :show, status: :created, location: @gallery }
    else
      format.html { render :new }
      format.json { render json: @gallery.errors, status: :unprocessable_entity }
    end
  end
end
```

**In views/galleries/_form.html.erb**
*Add content*
```
<%= f.fields_for :gallery_attachments do |f| %>
  <div class="field">
    <%= f.label :image, "Choose multi images" %>
    <%= f.file_field :image, multiple: true, name: "gallery_attachments[image][]" %>
  </div>
<% end %>
```

**In views/galleries/show.html.erb**
```
<p id="notice"><%= notice %></p>

<p>
  <strong>Name:</strong>
  <%= @gallery.name %>
</p>
<p>
	<% @gallery_attachments.each do |g| %>
		<%= image_tag g.image_url(:thumb) %>
	<% end %>
</p>
```

#### Edit attachment
**Update gallery_attachments/_form.html.erb
```
<%= image_tag @gallery_attachment.image_url(:thumb) %>
<%= form_for(@gallery_attachment) do |f| %>
  <div class="field">
    <%= f.file_field :image %>
  </div>
  <div class="actions">
    <%= f.submit %>
  </div>
<% end %>
```
**gallery_attachment_controller.rb**
```
def update
  respond_to do |format|
    if @gallery_attachment.update(gallery_attachment_params)
      format.html { redirect_to @gallery_attachment.gallery, notice: 'Gallery attachment was successfully updated.' }
    end
  end
end
```


