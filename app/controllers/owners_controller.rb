class OwnersController < ApplicationController
  before_action :set_owner, only: [:show, :update, :destroy]

  # GET /owners
  def index
    @owners = Owner.all
    render json: @owners
  end

  # GET /owners/:id
  def show
    render json: @owner
  end

  # POST /owners
  def create
    @owner = Owner.create!(owner_params)
    render json: @owner
  end

  # PUT /owners/:id
  def update
    @owner.update(owner_params)
    head :no_content
  end

  # DELETE /owners/:id
  def destroy
    @owner.destroy
    head :no_content
  end

  private

  def owner_params
    params.permit(
                  :category,
                  :type,
                  :email,
                  :phone,
                  :name
                )
  end

  def set_owner
    begin
      @owner = Owner.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render :json => "record not found"
    end
  end
end
