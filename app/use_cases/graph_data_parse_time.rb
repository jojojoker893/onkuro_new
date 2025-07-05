class GraphDataParseTime
  def initialize(date)
    @date = date
  end

  def call
    return nil if date.blank?

    Time.zone.parse(date)
  rescue ArgumentError
    nil
  end

  private

  attr_reader :date
end
