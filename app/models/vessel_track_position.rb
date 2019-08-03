class VesselTrackPosition < ActiveRecord::Base
  # <VESSELTRACK>
  #   <POSITION MMSI="257567010" STATUS="99" SPEED="2" LON="-28.625310" LAT="38.530840" COURSE="0" HEADING="511" TIMESTAMP="2019-08-02T14:19:00" SHIP_ID="4131836" />
  #   <POSITION MMSI="257567010" STATUS="99" SPEED="2" LON="-28.625300" LAT="38.530850" COURSE="0" HEADING="511" TIMESTAMP="2019-08-03T00:19:00" SHIP_ID="4131836" />
  # </VESSELTRACK>

  def alt
    0
  end

  def seen_at
    timestamp
  end

  def lng
    lon
  end
end
