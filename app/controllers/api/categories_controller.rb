module Api
  class CategoriesController < Api::BaseController

    private
      def category_params
        params.require(:category).permit(:name, :description, :parent, :slug)
      end

      def query_params
        params.permit(:name, :parent)
      end

  end
end
