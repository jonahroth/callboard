class MobileController < ApplicationController
  def code
    production = Production.find_by(ios_code: params['ios_code'])
    if production
      production = Production.find_by(ios_code: params['ios_code'])
      render json: production
    else
      head :not_found
    end
  end

  def cell
  end

  def refresh
  end
end
