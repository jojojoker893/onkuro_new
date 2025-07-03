class UsageLogClearing::CreateForm
  Result = Data.define(:success?, :error_message)

  def initialize(clothing:, user:)
    @clothing = clothing
    @user = user
  end

  # @return [UsageLogClearing::Create::Result]
  def save
    return Result.new(success?: false, error_message: "使用回数をこれ以上減らせません") if can_reduce_usage?

    if clearing_log.save
      Result.new(success?: true, error_message: nil)
    else
      Result.new(success?: false, error_message: clearing_log.errors.full_messages.to_sentence)
    end
  end

  private

  attr_reader :clothing, :user
  # note 使用回数を減らせるかチェックする
  # return [Boolen]
  def can_reduce_usage?
    clothing.clothing_usage_logs.count <= clothing.usage_log_clearing.count
  end

  # @return [UsgaeLogClearing]
  def clearing_log
    @clearing_log ||= UsageLogClearing.new(
      user: user,
      clothing: clothing,
      reduced_at: Time.current
    )
  end
end
