module Api
  class CategoriesController < Api::BaseController
    before_action :set_parent_params

    private
      def category_params
        params.require(:category).permit(:name, :description, :parent, :slug)
      end

      def query_params
        params.permit(:name, :parent_slug)
      end

      def set_parent_params
        params[:parent_slug] = nil if params[:parent_slug].nil?
      end

  end
end
