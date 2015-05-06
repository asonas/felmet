require 'csv'

headers = []

generated_csv = CSV.generate(headers: headers, write_headers: true, row_sep: "\r\n") do |csv|
  @events.each do |event|
    csv << [
      @user.name,
      event.location.name,
      event.checkin_at,
      event.checkout_at,
      event.enrollment_time,
    ]
  end
  csv << [nil, nil, nil, "合計時間", Event.sum_enrollment_time(@events)]
end
