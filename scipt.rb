require 'uri'
require 'net/http'
require 'csv'
require 'json'

@all = CSV.open('kek.csv')
@out = CSV.open('out.csv', 'w')

@all.each_with_index do |row, index|
  return if index == 1

  @all.each do |row2|
    # exclude urself
    next if row2[1] == row[1]

    uri = URI.parse("https://maps.googleapis.com/maps/api/distancematrix/json?origins=#{row[1].gsub(/[\u0080-\u00ff]/, '')}&destinations=#{row2[1].gsub(/[\u0080-\u00ff]/, '')}&key=AIzaSyAeQ5ZbZQQSkyySO0iP6CC__3V9qpvUacg")
    r = Net::HTTP.get(uri)
    puts r.to_s
    @out << [row[1], row2[1], JSON.parse(r).to_s, '\n']
  end
ensure
  @out.close
end
