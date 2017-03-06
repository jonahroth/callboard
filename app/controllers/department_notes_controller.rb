class DepartmentNotesController < ApplicationController
  before_action :set_department_note, only: [:show, :edit, :update, :destroy]

  # GET /department_notes
  # GET /department_notes.json
  def index
    @department_notes = DepartmentNote.all
  end

  # GET /department_notes/1
  # GET /department_notes/1.json
  def show
  end

  # GET /department_notes/new
  def new
    @department_note = DepartmentNote.new
  end

  # GET /department_notes/1/edit
  def edit
  end

  # POST /department_notes
  # POST /department_notes.json
  def create
    @department_note = DepartmentNote.new(department_note_params)

    respond_to do |format|
      if @department_note.save
        format.html { redirect_to @department_note, notice: 'Department note was successfully created.' }
        format.json { render :show, status: :created, location: @department_note }
      else
        format.html { render :new }
        format.json { render json: @department_note.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /department_notes/1
  # PATCH/PUT /department_notes/1.json
  def update
    respond_to do |format|
      if @department_note.update(department_note_params)
        format.html { redirect_to @department_note, notice: 'Department note was successfully updated.' }
        format.json { render :show, status: :ok, location: @department_note }
      else
        format.html { render :edit }
        format.json { render json: @department_note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /department_notes/1
  # DELETE /department_notes/1.json
  def destroy
    @department_note.destroy
    respond_to do |format|
      format.html { redirect_to department_notes_url, notice: 'Department note was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_department_note
      @department_note = DepartmentNote.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def department_note_params
      params.require(:department_note).permit(:department_id, :note_id)
    end
end
