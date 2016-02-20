module Api
  class CategoriesController < Api::BaseController
    before_action :set_parent_params

    private
      def category_params
        params.require(:category).permit(:name, :description, :parent_id)
      end

      def query_params
        params.permit(:name, :level, :parent_id)
      end

      def set_parent_params
        params[:parent_id] = nil if  params[:parent_id].present? and params[:parent_id].empty?
      end

  end
end
