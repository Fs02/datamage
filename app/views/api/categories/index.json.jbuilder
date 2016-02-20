json.categories @categories do |category|
  json.id           category._id.to_s
  json.name         category.name
  json.description  category.description
  json.child_count  category.child_count
  json.level        category.level
  json.parent_id    category.parent_id
end
