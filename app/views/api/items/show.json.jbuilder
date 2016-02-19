json.id           @item._id.to_s
json.caption      @item.caption
json.image_url    "api/items/#{@item._id.to_s}/image"
json.category_id  @item.category_id.to_s
