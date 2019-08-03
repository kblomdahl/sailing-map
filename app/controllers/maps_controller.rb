class MapsController < ApplicationController
  before_action :require_from
  before_action :set_from
  before_action :set_mmsi
  before_action :set_waypoints, only: :index

  def index
    @all_from = Email.order(:from).distinct(:from).pluck(:from)
  end

  protected

  def set_from
    @from = params[:from] || 'nil'
  end

  def set_mmsi
    @mmsi = EmailToMmsi.where(email: @from).first&.mmsi
  end

  def set_waypoints
    @waypoints = Email.where(from: @from) + VesselTrackPosition.where(mmsi: @mmsi).sort_by(&:seen_at)
    @waypoints.sort_by!(&:seen_at)

    # try to get an update from MarineTraffic about the boats position
    from_date =  @waypoints.last.seen_at.utc

    if @mmsi && @waypoints.last.seen_at < (Time.now.utc - 6.hours)
      MarineTrafficPosition.for_vessel(@mmsi, from_date).each do |position|
        puts(position.attributes)
        @waypoints << VesselTrackPosition.create(
          mmsi: position.MMSI,
          status: position.STATUS&.to_i,
          speed: position.SPEED&.to_d,
          lon: position.LON&.to_d,
          lat: position.LAT&.to_d,
          course: position.COURSE&.to_d,
          heading: position.HEADING&.to_d,
          timestamp: Date.parse(position.TIMESTAMP),
          shipid: position.SHIP_ID
        )
      end
    end
  end

  def require_from
    unless params[:from]
      most_recent = Email.order(:created_at).last&.from || 'nil'
      redirect_to root_path(from: most_recent)
    end
  end
end
