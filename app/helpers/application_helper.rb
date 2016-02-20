module ApplicationHelper
  def category_tree(category)
    category.map do |k, v|
      {
        category: {
          id: v[:id],
          name: v[:name],
          description: v[:description],
          path: v[:path],
          childs: (v[:childs].empty? ? [] : category_tree(v[:childs]))
        }
      }
    end
  end
end
