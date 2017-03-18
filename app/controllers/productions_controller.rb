class ProductionsController < ApplicationController
  before_action :set_production, only: [:show, :edit, :update, :destroy]

  def index
    @productions = Production.all
  end

  def show
  end

  def new
    @production = Production.new
  end

  def edit
  end

  def create
    @production = Production.new(production_params)

    respond_to do |format|
      if @production.save
        format.html { redirect_to @production, notice: 'Production was successfully created.' }
        format.json { render :show, status: :created, location: @production }
      else
        format.html { render :new }
        format.json { render json: @production.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @production.update(production_params)
        format.html { redirect_to @production, notice: 'Production was successfully updated.' }
        format.json { render :show, status: :ok, location: @production }
      else
        format.html { render :edit }
        format.json { render json: @production.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @production.destroy
    respond_to do |format|
      format.html { redirect_to productions_url, notice: 'Production was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_production
      @production = Production.find(params[:id])
    end

    def production_params
      params.require(:production).permit(:title, :first_rehearsal, :last_rehearsal)
    end
end
