class MarineTrafficPosition < ActiveResource::Base
  self.site = "https://services.marinetraffic.com/api/exportvesseltrack"

  def self.for_vessel(mmsi, from_date)
    mmsi = URI.encode(mmsi)
    from_date = URI.encode(from_date.strftime('%Y-%m-%d %H:%M:%S'))

    MarineTrafficPosition.all(
      from: "https://services.marinetraffic.com/api/exportvesseltrack/#{ENV['MARINE_TRAFFIC_API_KEY']}/v:2/protocol:jsono/period:daily/fromdate:#{from_date}/mmsi:#{mmsi}"
    )
  end
end
