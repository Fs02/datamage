class Item
  include Mongoid::Document

  mount_uploader :image, ImageUploader

  field :caption, type: String
end
