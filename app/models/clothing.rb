class Clothing < ApplicationRecord
  belongs_to :user
  belongs_to :category
  belongs_to :brand
  belongs_to :color

  has_one_attached :image
  has_many :clothing_usage_logs, dependent: :destroy

  def self.search_with_params(user:, params:)
    clothings = user.clothings
    clothings = clothings.search_keyword(params[:keyword]) if params[:keyword].present?  # 検索
    clothings = clothings.filter_category(params[:category_id]) if params[:category_id].present? # カテゴリフィルター

    case params[:order] # ソート機能
    when "usage_asc", "usage_desc"
      clothings = clothings.usage_log_count.order_usage(params[:order] == "usage_asc" ? "ASC" : "DESC")
    else
      clothings = clothings.order_created_at
    end

    clothings
  end

  # @@使用回数を取得
  scope :usage_log_count, -> {
    left_joins(:clothing_usage_logs)
    .select("clothings.*, COUNT(clothing_usage_logs.id) AS usage_count")
    .group("clothings.id")
  }

  # @@登録順
  scope :order_created_at, -> { order(created_at: :desc) }

  # @@使用回数の降順、昇順で並び替え
  scope :order_usage, ->(sort_order = "DESC") { order(Arel.sql("usage_count #{sort_order}")) }

  # @@絞り機能 カテゴリ、ブランド、カラー
  scope :filter_category, ->(category_id) { where(category_id: category_id)  if category_id.present? }

  # @@検索機能
  scope :search_keyword, ->(keyword) { where("name LIKE ?", "%" + keyword + "%") }
end
