json.array!(@gallery_attachments) do |gallery_attachment|
  json.extract! gallery_attachment, :id, :gallery_id, :image
  json.url gallery_attachment_url(gallery_attachment, format: :json)
end
