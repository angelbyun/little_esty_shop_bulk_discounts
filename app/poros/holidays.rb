class Holidays
  attr_reader :data,
              :holiday_1,
              :holiday_2,
              :holiday_3
              
  def initialize(data)
    @data = data
    @holiday_1 = @data[0]
    @holiday_2 = @data[1]
    @holiday_3 = @data[2]
  end
end