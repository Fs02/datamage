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
  field :roi_top, type: String, default: 0
  field :roi_left, type: String, default: 0
  field :roi_width, type: String, default: 0
  field :roi_height, type: String, default: 0
  field :phash, type: String
  field :duplicates, type: Array, default: []
  belongs_to :category

  validates_with LeafCategoryValidator

  after_save :detect_duplicates

  def detect_duplicates
    filename = self.image.model.read_attribute(:image)
    path = "#{Rails.root}/tmp/item_#{self._id.to_s}/"

    Rails.logger.info "[Detect Duplicates (#{self.id.to_s})] Creating temporary files from #{path+filename}"
    FileUtils.mkdir_p path
    File.open(path + filename, 'wb').write self.image.read

    Rails.logger.info "[Detect Duplicates (#{self.id.to_s})] Extracting pHash from #{path+filename}"
    self.set(phash: Phashion.image_hash_for(path + filename).to_s)

    Rails.logger.info "[Detect Duplicates (#{self.id.to_s})] Removing temporary directory #{path+filename}"
    FileUtils.remove_dir path, true

    batch_iter = 0
    batch_size = 100
    duplicates = []
    while (items = Item.limit(batch_size).skip(batch_iter * batch_size).pluck(:id, :phash).to_a).present?
      items.each do |i|
        if not i[1].nil? and Phashion.hamming_distance(self.phash.to_i, i[1].to_i) < 15
          duplicates += [i[0]]
        end
      end

      batch_iter += 1
    end

    self.set(duplicates: duplicates)
#    self.save!
    Rails.logger.info "[Detect Duplicates (#{self.id.to_s})] Found #{self.duplicates.count} duplicates"
  end

end
