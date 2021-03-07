# frozen_string_literal: true

class OwnersController < ApplicationController
  before_action :set_owner, only: %i[show update destroy]

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

  # POST /create_from_link
  def create_from_link
    data = Scraper.new(params['link']).parsed_data
    @owner = Owner.where(phone: data[:owner_params][:phone]).first_or_create!(data[:owner_params])
    @house = @owner.houses.create!(data[:house_params])

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
    @owner = Owner.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: 'record not found'
  end

  def owner_exists?(phone)
    Owner.where(phone: phone)
  end
end
