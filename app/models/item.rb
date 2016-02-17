class Item
  include Mongoid::Document
  include Mongoid::Timestamps

  mount_uploader :image, ImageUploader

  field :caption, type: String
end
