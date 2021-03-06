class HousesController < ApplicationController
  before_action :set_owner
  before_action :set_house, only: [:show, :update, :destroy]

  # GET /houses
  def index
    @houses = House.all
    render json: @houses
  end

  # GET /owners/owner_id/houses/:id
  def show
    render json: @house
  end

  # POST /houses
  def create
    @house = @owner.houses.create!(house_params)
    render json: @house
  end

   # PUT /owners/owner_id/houses/:id
   def update
    @house.update(house_params)
    head :no_content
  end

  # DELETE /owners/owner_id/houses/:id
  def destroy
    @house.destroy
    head :no_content
  end

  private

  def house_params
    params.permit(
                  :category,
                  :size,
                  :rooms,
                  :bathrooms,
                  :price,
                  :description,
                  :link,
                  :contact_person_id
                )
  end

  def set_owner
    @owner = Owner.find(params[:owner_id])
  end

  def set_house
    begin
      @house = House.find(params[:id]) if @owner
    rescue ActiveRecord::RecordNotFound
      render :json => "record not found"
    end
  end
end
