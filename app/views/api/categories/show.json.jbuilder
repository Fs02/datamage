json.category do
  json.id           @category._id.to_s
  json.name         @category.name
  json.description  @category.description
  json.parent       @category.parent
  json.slug         @category.slug
end
