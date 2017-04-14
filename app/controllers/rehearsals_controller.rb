class RehearsalsController < ApplicationController
  before_action :set_rehearsal, only: [:show, :edit, :update, :destroy]

  def index
    @rehearsals = Rehearsal.all
  end

  def show
  end

  def new
    @rehearsal = Rehearsal.new
  end

  def edit
  end

  def create
    @rehearsal = Rehearsal.new(rehearsal_params)

    respond_to do |format|
      if @rehearsal.save
        format.html { redirect_to @rehearsal, notice: 'Rehearsal was successfully created.' }
        format.json { render :show, status: :created, location: @rehearsal }
      else
        format.html { render :new }
        format.json { render json: @rehearsal.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @rehearsal.update(rehearsal_params)
        format.html { redirect_to @rehearsal, notice: 'Rehearsal was successfully updated.' }
        format.json { render :show, status: :ok, location: @rehearsal }
      else
        format.html { render :edit }
        format.json { render json: @rehearsal.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @rehearsal.destroy
    respond_to do |format|
      format.html { redirect_to rehearsals_url, notice: 'Rehearsal was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_rehearsal
      @rehearsal = Rehearsal.find(params[:id])
    end

    def rehearsal_params
      params.require(:rehearsal).permit(:title, :start_time, :production_id, :schedule_id,
                                        works: [:name, :work_type, :duration, :break_duration, :rehearsal_id,
                                                :production_id, :swappable])
    end
end
