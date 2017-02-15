class CrewCallsController < ApplicationController
  before_action :set_crew_call, only: [:show, :edit, :update, :destroy]

  # GET /crew_calls
  # GET /crew_calls.json
  def index
    @crew_calls = CrewCall.all
  end

  # GET /crew_calls/1
  # GET /crew_calls/1.json
  def show
  end

  # GET /crew_calls/new
  def new
    @crew_call = CrewCall.new
  end

  # GET /crew_calls/1/edit
  def edit
  end

  # POST /crew_calls
  # POST /crew_calls.json
  def create
    @crew_call = CrewCall.new(crew_call_params)

    respond_to do |format|
      if @crew_call.save
        format.html { redirect_to @crew_call, notice: 'Crew call was successfully created.' }
        format.json { render :show, status: :created, location: @crew_call }
      else
        format.html { render :new }
        format.json { render json: @crew_call.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /crew_calls/1
  # PATCH/PUT /crew_calls/1.json
  def update
    respond_to do |format|
      if @crew_call.update(crew_call_params)
        format.html { redirect_to @crew_call, notice: 'Crew call was successfully updated.' }
        format.json { render :show, status: :ok, location: @crew_call }
      else
        format.html { render :edit }
        format.json { render json: @crew_call.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /crew_calls/1
  # DELETE /crew_calls/1.json
  def destroy
    @crew_call.destroy
    respond_to do |format|
      format.html { redirect_to crew_calls_url, notice: 'Crew call was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_crew_call
      @crew_call = CrewCall.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def crew_call_params
      params.require(:crew_call).permit(:crew_role_id, :rehearsal_id)
    end
end
