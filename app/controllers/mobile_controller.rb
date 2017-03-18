class MobileController < ApplicationController
  before_action { respond_to :json }
  def code
    production = Production.find_by(ios_code: params['ios_code'])
    if production
      render json: production
    else
      head :not_found
    end
  end

  def cell
    production = Production.find_by(id: params['production_id'].to_i)
    person = Person.find_by(cell: params['cell'])
    if production && person
      person.ios_uuid = params['uuid']
      person.save!
      # TODO: return schedule
      render json: production
    else
      head :bad_request
    end
  end

  def refresh
    production = Production.find_by(id: params['production_id'].to_i)
    person = Person.find_by(ios_uuid: params['uuid'])
    if production && person && person.production == production
      render json: production
    else
      head :not_found
    end
  end
end
