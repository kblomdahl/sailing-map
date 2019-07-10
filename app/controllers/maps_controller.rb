class MapsController < ApplicationController
  before_action :require_from

  def index
    @all_from = Email.order(:from).distinct(:from).pluck(:from)
    @from = params[:from] || 'nil'
    @waypoints = Email.where(from: @from).sort_by(&:seen_at)
  end

  protected

  def require_from
    unless params[:from]
      most_recent = Email.order(:created_at).last&.from || 'nil'
      redirect_to root_path(from: most_recent)
    end
  end
end
