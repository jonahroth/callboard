class CrewRolesController < ApplicationController
  before_action :set_crew_role, only: [:show, :edit, :update, :destroy]

  # GET /crew_roles
  # GET /crew_roles.json
  def index
    @crew_roles = CrewRole.all
  end

  # GET /crew_roles/1
  # GET /crew_roles/1.json
  def show
  end

  # GET /crew_roles/new
  def new
    @crew_role = CrewRole.new
  end

  # GET /crew_roles/1/edit
  def edit
  end

  # POST /crew_roles
  # POST /crew_roles.json
  def create
    @crew_role = CrewRole.new(crew_role_params)

    respond_to do |format|
      if @crew_role.save
        format.html { redirect_to @crew_role, notice: 'Crew role was successfully created.' }
        format.json { render :show, status: :created, location: @crew_role }
      else
        format.html { render :new }
        format.json { render json: @crew_role.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /crew_roles/1
  # PATCH/PUT /crew_roles/1.json
  def update
    respond_to do |format|
      if @crew_role.update(crew_role_params)
        format.html { redirect_to @crew_role, notice: 'Crew role was successfully updated.' }
        format.json { render :show, status: :ok, location: @crew_role }
      else
        format.html { render :edit }
        format.json { render json: @crew_role.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /crew_roles/1
  # DELETE /crew_roles/1.json
  def destroy
    @crew_role.destroy
    respond_to do |format|
      format.html { redirect_to crew_roles_url, notice: 'Crew role was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_crew_role
      @crew_role = CrewRole.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def crew_role_params
      params.require(:crew_role).permit(:person_id, :title)
    end
end
