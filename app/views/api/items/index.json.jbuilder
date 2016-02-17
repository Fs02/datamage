json.items @items do |item|
  json.id           item._id.to_s
  json.caption      item.caption
end
