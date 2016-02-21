module Api
  class ItemsController < Api::BaseController
    before_action :set_resource, only: [:destroy, :show, :update, :image]
    before_action :set_image, only: [:create, :update]

    def image
      content = nil
      if params[:version] == 'thumb'
        content = get_resource.image.thumb.read
      else
        content = get_resource.image.read
      end

      if stale?(etag: content, last_modified: get_resource.updated_at.utc, public: true)
        send_data content, type: get_resource.image.file.content_type, disposition: "inline"
        expires_in 0, public: true
      end
    end

    private
      def set_image
        if params[:item][:image_url]
          uploader = ImageUploader.new
          uploader.download! params[:item][:image_url]
          uploader.store!
        else
          params[:item][:image] = params[:file]
        end
      end

      def item_params
        params.require(:item).permit(:caption, :image, :category_id, :roi_top, :roi_left, :roi_width, :roi_height)
      end

      def query_params
        params.permit(:caption, :category_id)
      end

  end
end
