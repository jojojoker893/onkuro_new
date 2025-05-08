class ClothingReport
  ORDER_DIRECTIONS = {
    "usage_asc" => "ASC",
    "usage_desc" => "DESC"
}.freeze

  def initialize(user_id:, params:)
    @user_id = user_id
    @params = params
  end

  def call
    clothings = Clothing.where(user_id: user_id)
    clothings = clothings.search_keyword(params[:keyword]) if params[:keyword].present?  # 検索
    clothings = clothings.filter_category(params[:category_id]) if params[:category_id].present? # カテゴリフィルター
    clothings = clothings.filter_brand(params[:brand_id]) if params[:brand_id].present? # ブランドフィルター
    clothings = clothings.filter_color(params[:color_id]) if params[:color_id].present? # カラーフィルター


    apply_ordering(clothings)
  end

  private

  attr_reader :user_id, :params

  def apply_ordering(scope) # 並び替え
    if order_direction.present?
      scope.usage_log_count.order_usage(order_direction)
    else
    scope.order_created_at
    end
  end
  def order_direction = ORDER_DIRECTIONS[@params[:order]]
end
