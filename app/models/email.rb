class Email < ActiveRecord::Base
  # I am here Lat+27.020557 Lon-77.252668 Alt+117ft GPS Sats seen 09 2019-06-26 03:30UTC http://map.iridium.com/m?lat=27.020557&lon=-77.252668 Sent via Iridium GO!

  def alt
    m = body&.match /Alt([+-][0-9\.]*\w*)/i
    m.captures[0] if m
  end

  def lat
    m = body&.match /Lat([+-][0-9\.]*)/i
    m.captures[0] if m
  end

  def lng
    m = body&.match /Lon([+-][0-9\.]*)/i
    m.captures[0] if m
  end

  def seen_at
    m = body&.match /([0-9]+-[0-9]+-[0-9]+\s+[0-9]+:[0-9]+UTC)/i
    m.captures[0].to_datetime if m
  end
end
