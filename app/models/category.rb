class Category
  include Mongoid::Document
  field :name, type: String
  field :description, type: String
  field :parent, type: Category
  field :slug, type: String

  scope :root, ->{ where(parent: nil) }

  index({ slug: 1 }, { unique: true })
  index({ parent: 1 })

  before_save :update_slug

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
end
