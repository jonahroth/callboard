class WorksController < ApplicationController
  before_action :set_work, only: [:show, :edit, :update, :destroy]

  def index
    @works = Work.where(production_id: current_user.person.production_id)
  end

  def show
  end

  def new
    @work = Work.new
  end

  def edit
  end

  def create
    @work = Work.new(work_params.merge(production_id: current_user.person.production_id))

    respond_to do |format|
      if @work.save
        format.html { redirect_to @work, notice: 'Work was successfully created.' }
        format.json { render :show, status: :created, location: @work }
      else
        format.html { render :new }
        format.json { render json: @work.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @work.update_attributes(work_params)
        format.html { redirect_to @work, notice: 'Work was successfully updated.' }
        format.json { render :show, status: :ok, location: @work }
      else
        format.html { render :edit }
        format.json { render json: @work.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @work.destroy
    respond_to do |format|
      format.html { redirect_to works_url, notice: 'Work was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def getAll
    @work.id = Work.where(production_id: current_user.person.production_id).where.not(id: self.id).select do |w|
      holder = Array.new(5000, hash.new)
      used = 0
      if w.fits?(start_datetime) 
        #format.html { render :new }
        #format.json { render json: @work.id }
        holder[used]
        used += 1
      end
      smallHolder = holder[0,used]
      format.json { render json: smallHolder }
    end
  end

  private
    def set_work
      @work = Work.find(params[:id])
    end

    def work_params
      params.require(:work).permit(:id, :name, :production_id, :work_type, :duration, :break_duration,
                                   :rehearsal_id, :sequence_id,
                                   :person_works_attributes => [:id, :person_id, :work_id, :_destroy])
    end
end
