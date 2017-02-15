class RehearsalScenesController < ApplicationController
  before_action :set_rehearsal_scene, only: [:show, :edit, :update, :destroy]

  # GET /rehearsal_scenes
  # GET /rehearsal_scenes.json
  def index
    @rehearsal_scenes = RehearsalScene.all
  end

  # GET /rehearsal_scenes/1
  # GET /rehearsal_scenes/1.json
  def show
  end

  # GET /rehearsal_scenes/new
  def new
    @rehearsal_scene = RehearsalScene.new
  end

  # GET /rehearsal_scenes/1/edit
  def edit
  end

  # POST /rehearsal_scenes
  # POST /rehearsal_scenes.json
  def create
    @rehearsal_scene = RehearsalScene.new(rehearsal_scene_params)

    respond_to do |format|
      if @rehearsal_scene.save
        format.html { redirect_to @rehearsal_scene, notice: 'Rehearsal scene was successfully created.' }
        format.json { render :show, status: :created, location: @rehearsal_scene }
      else
        format.html { render :new }
        format.json { render json: @rehearsal_scene.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rehearsal_scenes/1
  # PATCH/PUT /rehearsal_scenes/1.json
  def update
    respond_to do |format|
      if @rehearsal_scene.update(rehearsal_scene_params)
        format.html { redirect_to @rehearsal_scene, notice: 'Rehearsal scene was successfully updated.' }
        format.json { render :show, status: :ok, location: @rehearsal_scene }
      else
        format.html { render :edit }
        format.json { render json: @rehearsal_scene.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rehearsal_scenes/1
  # DELETE /rehearsal_scenes/1.json
  def destroy
    @rehearsal_scene.destroy
    respond_to do |format|
      format.html { redirect_to rehearsal_scenes_url, notice: 'Rehearsal scene was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rehearsal_scene
      @rehearsal_scene = RehearsalScene.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rehearsal_scene_params
      params.require(:rehearsal_scene).permit(:rehearsal_id, :scene_id, :expected_start, :expected_end, :actual_start, :actual_end)
    end
end
