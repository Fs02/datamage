json.item do
  json.id           @item._id.to_s
  json.caption      @item.caption
end
