class CagesController < ApplicationController
  before_action :set_cage, only: %i[ show update destroy ]

  # GET /cages
  # GET /cages.json
  def index
    @cages = Cage.all
  end

  # GET /cages/1
  # GET /cages/1.json
  def show
  end

  # POST /cages
  # POST /cages.json
  def create
    @cage = Cage.new(cage_params)

    if @cage.save
      render :show, status: :created, location: @cage
    else
      render json: @cage.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /cages/1
  # PATCH/PUT /cages/1.json
  def update
    if @cage.update(cage_params)
      render :show, status: :ok, location: @cage
    else
      render json: @cage.errors, status: :unprocessable_entity
    end
  end

  # DELETE /cages/1
  # DELETE /cages/1.json
  def destroy
    @cage.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cage
      @cage = Cage.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def cage_params
      params.require(:cage).permit(:max_capacity, :dinosaur_count, :power_status, :location, :tag)
    end
end
