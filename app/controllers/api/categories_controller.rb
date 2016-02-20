module Api
  class CategoriesController < Api::BaseController
    before_action :set_parent_params

    def tree
      @categories = Hash.new { |hash, key| hash[key] = {} }
      Category.order_by(level: 'asc').to_a.each do |c|
        parent = @categories[(c.level-1).to_s][c.parent_id] if c.level > 0
        cat = @categories[c.level.to_s][c.id.to_s] = {
          id: c.id.to_s,
          name: c.name,
          description: c.description,
          path: (c.level > 0 ? (parent[:path].present? ? parent[:path] + " - " : '') + parent[:name] : ''),
          childs: {}
        }
        parent[:childs][cat[:id]] = cat if parent
      end
      @categories = @categories["0"] # root
    end

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
