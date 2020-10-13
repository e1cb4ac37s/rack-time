class TimeParser
  FORMATTERS = {
    'year'   => '%Y',
    'month'  => '%m',
    'day'    => '%d',
    'hour'   => '%H',
    'minute' => '%M',
    'second' => '%S'
  }

  def self.call(params)
    self.new(params)
  end

  def initialize(params)
    @format = params['format']
    @format_arr = []
    @invalid = []
    parse
  end

  def body
    Time.now.strftime(@format_arr.join('-')) if valid?
  end

  def valid?
    @invalid.empty? && @format_arr.any?
  end

  def error_message
    unless valid?
      return "Unknown time format #{@invalid}" if @invalid.any?
      return "Format is not specified" if @format_arr.empty?
    end
  end

  private

  def parse
    if @format
      @format.split(',').each do |f|
        if FORMATTERS[f]
          @format_arr << FORMATTERS[f]
        else
          @invalid << f
        end
      end
    end
  end
end
