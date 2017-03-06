class CharacterScenesController < ApplicationController
  before_action :set_character_scene, only: [:show, :edit, :update, :destroy]

  # GET /character_scenes
  # GET /character_scenes.json
  def index
    @character_scenes = CharacterScene.all
  end

  # GET /character_scenes/1
  # GET /character_scenes/1.json
  def show
  end

  # GET /character_scenes/new
  def new
    @character_scene = CharacterScene.new
  end

  # GET /character_scenes/1/edit
  def edit
  end

  # POST /character_scenes
  # POST /character_scenes.json
  def create
    @character_scene = CharacterScene.new(character_scene_params)

    respond_to do |format|
      if @character_scene.save
        format.html { redirect_to @character_scene, notice: 'Character scene was successfully created.' }
        format.json { render :show, status: :created, location: @character_scene }
      else
        format.html { render :new }
        format.json { render json: @character_scene.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /character_scenes/1
  # PATCH/PUT /character_scenes/1.json
  def update
    respond_to do |format|
      if @character_scene.update(character_scene_params)
        format.html { redirect_to @character_scene, notice: 'Character scene was successfully updated.' }
        format.json { render :show, status: :ok, location: @character_scene }
      else
        format.html { render :edit }
        format.json { render json: @character_scene.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /character_scenes/1
  # DELETE /character_scenes/1.json
  def destroy
    @character_scene.destroy
    respond_to do |format|
      format.html { redirect_to character_scenes_url, notice: 'Character scene was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_character_scene
      @character_scene = CharacterScene.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def character_scene_params
      params.require(:character_scene).permit(:character_id, :scene_id)
    end
end
