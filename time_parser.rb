class TimeParser
  FORMATTERS = {
    'year'   => '%Y',
    'month'  => '%m',
    'day'    => '%d',
    'hour'   => '%H',
    'minute' => '%M',
    'second' => '%S'
  }

  def initialize(params)
    @format_arr = []
    @invalid = []
    if params['format']
      params['format'].split(',').each do |f|
        if FORMATTERS[f]
          @format_arr << FORMATTERS[f]
        else
          @invalid << f
        end
      end
    end
  end

  def body
    return "Unknown time format #{@invalid}" if @invalid.any?

    return "Format is not specified" if @format_arr.empty?

    Time.now.strftime(@format_arr.join('-'))
  end

  def valid?
    @invalid.empty? && @format_arr.any?
  end
end
