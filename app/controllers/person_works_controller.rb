class PersonWorksController < ApplicationController
  before_action :set_person_work, only: [:show, :edit, :update, :destroy]

  # GET /person_works
  # GET /person_works.json
  def index
    @person_works = PersonWork.all
  end

  # GET /person_works/1
  # GET /person_works/1.json
  def show
  end

  # GET /person_works/new
  def new
    @person_work = PersonWork.new
  end

  # GET /person_works/1/edit
  def edit
  end

  # POST /person_works
  # POST /person_works.json
  def create
    @person_work = PersonWork.new(person_work_params)

    respond_to do |format|
      if @person_work.save
        format.html { redirect_to @person_work, notice: 'Person work was successfully created.' }
        format.json { render :show, status: :created, location: @person_work }
      else
        format.html { render :new }
        format.json { render json: @person_work.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /person_works/1
  # PATCH/PUT /person_works/1.json
  def update
    respond_to do |format|
      if @person_work.update(person_work_params)
        format.html { redirect_to @person_work, notice: 'Person work was successfully updated.' }
        format.json { render :show, status: :ok, location: @person_work }
      else
        format.html { render :edit }
        format.json { render json: @person_work.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /person_works/1
  # DELETE /person_works/1.json
  def destroy
    @person_work.destroy
    respond_to do |format|
      format.html { redirect_to person_works_url, notice: 'Person work was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_person_work
      @person_work = PersonWork.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def person_work_params
      params.require(:person_work).permit(:person_id, :work_id)
    end
end
