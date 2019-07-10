class MailsController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :authenticate_cloudmailin, only: [:create]

  def create
    if ENV['CLOUDMAILIN_FORWARD_ADDRESS'].blank? || params[:envelope][:to] == ENV['CLOUDMAILIN_FORWARD_ADDRESS']
      subject = params[:headers][:subject]
      from_in_subject = subject&.match /SMS\s+from\s+(([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+)/i
      actually_from =
        if from_in_subject
          from_in_subject.captures[0]
        else
          params[:envelope][:from]
        end

      Email.create!(
        from: actually_from,
        subject: subject,
        body: params[:plain]
      )

      head :created
    else
      render plain: "Unknown user #{params[:envelope][:to]}", status: :not_found
    end
  end

  protected

  def authenticate_cloudmailin
    auth = authenticate_with_http_basic do |username, password|
      username == 'cloudmailin' && password == ENV['CLOUDMAILIN_PASSWORD']
    end
    return true if auth

    render plain: "Invalid credentials", status: :unauthorized
  end
end
