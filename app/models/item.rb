class LeafCategoryValidator < ActiveModel::Validator
  def validate(record)
    if record.category.nil?
      record.errors[:category] << "Category can't be empty"
    end
    if record.category.present? and not record.category.child_count.zero?
      record.errors[:category] << "Must be in leaf category"
    end
  end
end

class Item
  include Mongoid::Document
  include Mongoid::Timestamps

  mount_uploader :image, ImageUploader

  field :caption, type: String
  belongs_to :category

  validates_with LeafCategoryValidator
end
