class ApplicationController < ActionController::Base
    before_action :check_category_id
    before_action :check_ai_method
    include CommonMethods
    def check_category_id
        @category = Category.find_by(id: params[:category_id])
        if @category.present?
            @category.update(total_access: @category.total_access + 1)
            @categories = @category.child_categories
        else
            @categories = Category.where(parent_category: nil).order(total_access: :DESC)
        end
    end

    def check_ai_method
        puts "パラメータ"
        puts params[:ai_method]
        @ai_method = AiMethod.find_by(name:params[:ai_method])
    end
end
