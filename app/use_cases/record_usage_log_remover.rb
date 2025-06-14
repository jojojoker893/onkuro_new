class RecordUsageLogRemover
  def initialize(user:, clothing_id:)
    @user = user
    @clothing_id = clothing_id
  end

  def call # 使用回数を減らす
    clothing = user.clothings.find_by(id: clothing_id) # ユーザーの服を探す
    return false unless clothing # falseなら服を返す

    log = ClothingUsageLog.where(user: user, clothing: clothing) # 使用ログテーブルからユーザーの服を探し使用した降順にならべ最新のレコードを取得
    .order(used_at: :desc).first

    return false unless log # falseならlogを返す

    log.destroy # 対象レコードを消す
  end

  private

  attr_reader :user, :clothing_id
end
