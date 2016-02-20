module ApplicationHelper
  def tree(category)
    category.map do |k, v|
      {
        category: {
          id: v[:id],
          name: v[:name],
          description: v[:description],
          childs: (v[:childs].empty? ? [] : tree(v[:childs]))
        }
      }
    end
  end
end
