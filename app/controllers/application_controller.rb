class ApplicationController < ActionController::Base
  require 'scheduler/scheduler'
  protect_from_forgery with: :exception

  after_filter :set_csrf_cookie_for_ng

  rescue_from ActionController::UnknownFormat, with: :deny_access

  before_action :authenticate_user!

  # NOTE: http://stackoverflow.com/questions/14734243/rails-csrf-protection-angular-js-protect-from-forgery-makes-me-to-log-out-on
  def set_csrf_cookie_for_ng
    cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  end

  def deny_access
    respond_to do |format|
      # TODO make a nice HTML page showing why you can't access API endpoints
      format.html { head :bad_request }
    end
  end

  protected

  def verified_request?
    super || valid_authenticity_token?(session, request.headers['X-XSRF-TOKEN'])
  end
end
