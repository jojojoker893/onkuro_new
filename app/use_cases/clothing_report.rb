class ClothingReport
  ORDER_DIRECTIONS = {
    "usage_asc" => "ASC",
    "usage_desc" => "DESC"
  }.freeze

  # @param [Integer] user_id
  # @param [ActionController::Parameters] params
  def initialize(user_id:, params:)
    @user_id = user_id
    @params = params
  end

  # @return [Clothing::ActiveRecord_Relation]
  def call
    clothings = Clothing.where(user_id: user_id)
    clothings = clothings.search_keyword(params[:keyword]) if params[:keyword].present?
    clothings = clothings.filter_by_category(params[:category_id]) if params[:category_id].present?
    clothings = clothings.filter_by_brand(params[:brand_id]) if params[:brand_id].present?
    clothings = clothings.filter_by_color(params[:color_id]) if params[:color_id].present?

    clothings = clothings.preload(:category, :brand, :color, :clothing_usage_logs, :usage_log_clearing)

    apply_ordering(clothings)
      .page(params[:page])
      .per(8)
  end

  private

  attr_reader :user_id, :params

  # @note 使用回数順の並びと登録順の並びのどちらかを適用する
  # @param [Clothing::ActiveRecord_Relation] clothings
  # @return [Clothing::ActiveRecord_Relation]
  def apply_ordering(clothings)
    if order_direction.present?
      clothings.joins(:clothing_usage_logs)
               .left_joins(:usage_log_clearing)
               .group("clothings.id")
               .select("clothings.*, (COUNT(clothing_usage_logs.id) - COUNT(usage_log_clearings.id)) as usage_count")
               .order("usage_count #{order_direction}")
    else
      clothings.order_by_created_at
    end
  end

  # @return [String]
  def order_direction = ORDER_DIRECTIONS[@params[:order]]
end
