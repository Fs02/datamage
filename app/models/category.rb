class Category
  include Mongoid::Document
  field :name, type: String
  field :description, type: String
  field :parent_id, type: String
#  field :slug, type: String
  field :child_count, type: Integer, default: 0
  field :level, type: Integer, default: 0
  has_many :items

  scope :root, ->{ where(level: 0) }

#  index({ slug: 1 }, { unique: true })
  index({ parent_id: 1 })

#  before_save :update_slug
  before_save :update_parent

  private
    def update_slug
      if not self.slug.present? or self.slug_changed?
        slug = (self.slug.present? ? self.slug : self.name).parameterize.underscore

        duplicate = 0
        new_slug = slug
        Category.where(slug: Regexp.new(new_slug)).pluck(:slug).each do |s|
          if s == new_slug
            duplicate += 1
            new_slug = "#{slug}_#{duplicate}"
          end
        end
        self.slug = new_slug
      end
    end

    def update_parent
      if self.parent_id_changed?
        Rails.logger.info self.parent_id_was
        Category.find(self.parent_id_was).inc(child_count: -1) if self.parent_id_was.present?
        parent = Category.find(self.parent_id)
        parent.inc(child_count: 1)
        self.level = parent.level + 1
      end
    end
end
