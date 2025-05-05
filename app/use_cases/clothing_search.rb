class ClothingSearch
  attr_reader :user, :params

  def initialize(user:, params:)
    @user = user
    @params = params
  end

  def call
    clothings = Clothing.where(user_id: user_id)
    clothings = clothings.search_keyword(params[:keyword]) if params[:keyword].present?  # 検索
    clothings = clothings.filter_category(params[:category_id]) if params[:category_id].present? # カテゴリフィルター
    clothings = clothings.filter_brand(params[:brand_id]) if params[:brand_id].present? # ブランドフィルター
    clothings = clothings.filter_color(params[:color_id]) if params[:color_id].present? # カラーフィルター

    case params[:order] # ソート機能
    when "usage_asc", "usage_desc"
      clothings = clothings.usage_log_count.order_usage(params[:order] == "usage_asc" ? "ASC" : "DESC")
    else
      clothings = clothings.order_created_at
    end

    clothings
  end
end
