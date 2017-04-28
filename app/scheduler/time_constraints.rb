class TimeConstraints
  attr_accessor :sun_start, :sun_end, :mon_start, :mon_end, :tue_start,
    :tue_end, :wed_start, :wed_end, :thu_start, :thu_end, :fri_start,
    :fri_end, :sat_start, :sat_end

  def initialize(sun_start = 14, sun_end = 17, mon_start = 18, mon_end = 23,
                 tue_start = 18, tue_end = 23, wed_start = 18, wed_end = 23,
                 thu_start = 18, thu_end = 23, fri_start = 0, fri_end = 0,
                 sat_start = 14, sat_end = 17)
    @sun_start = sun_start
    @sun_end = sun_end
    @mon_start = mon_start
    @mon_end = mon_end
    @tue_start = tue_start
    @tue_end = tue_end
    @wed_start = wed_start
    @wed_end = wed_end
    @thu_start = thu_start
    @thu_end = thu_end
    @fri_start = fri_start
    @fri_end = fri_end
    @sat_start = sat_start
    @sat_end = sat_end
  end

end
