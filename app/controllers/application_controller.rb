class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  rescue_from ActionController::UnknownFormat, with: :deny_access

  def deny_access
    respond_to do |format|
      # TODO make a nice HTML page showing why you can't access API endpoints
      format.html { head :bad_request }
    end
  end
end
