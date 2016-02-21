json.id           @item._id.to_s
json.caption      @item.caption
json.roi_top      @item.roi_top
json.roi_left     @item.roi_left
json.roi_width    @item.roi_width
json.roi_height   @item.roi_height
json.image_url    "api/items/#{@item._id.to_s}/image"
json.category_id  @item.category_id.to_s
