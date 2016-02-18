json.category do
  json.id           @category._id.to_s
  json.name         @category.name
  json.description  @category.description
  json.child_count  @category.child_count
  json.parent_slug  @category.parent_slug
  json.slug         @category.slug
end
