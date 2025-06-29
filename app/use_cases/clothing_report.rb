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
    clothings = clothings.search_keyword(params[:keyword]) if params[:keyword].present?
    clothings = clothings.filter_by_category(params[:category_id]) if params[:category_id].present?
    clothings = clothings.filter_by_brand(params[:brand_id]) if params[:brand_id].present?
    clothings = clothings.filter_by_color(params[:color_id]) if params[:color_id].present?

    apply_ordering(clothings)
  end

  private

  attr_reader :user_id, :params

  def apply_ordering(clothings)
    if order_direction.present?
      result = clothings.joins(:clothing_usage_logs)
                        .group("clothings.id")
                        .order("COUNT(clothing_usage_logs.id) #{order_direction}")
                        .to_a

      Kaminari.paginate_array(result)
              .page(params[:page])
              .per(8)
    else
      clothings.order_by_created_at.page(params[:page]).per(8)
    end
  end

  def order_direction = ORDER_DIRECTIONS[@params[:order]]
end
