class Api::V1::FactsController < ApplicationController
  include AuthenticationCheck

  before_action :is_user_logged_in
  before_action :set_fact, only: %i[show update destroy]
  before_action :set_member, only: %i[index create]

  # GET /members/:member_id/facts
  def index
    render json: @member.facts
  end

  # GET /members/:member_id/facts/:id
  def show
    render json: @fact
  end

  # POST /members/:member_id/facts
  def create
    @fact = @member.facts.new(fact_params)
    if @fact.save
      render json: @fact, status: 201
    else
      render json: {
        error: "The fact entry could not be created: #{@fact.errors.full_messages.to_sentence}"
      }, status: 400
    end
  end

  # PATCH/PUT /members/:member_id/facts/:id
  def update
    if @fact.update(fact_params)
      render json: @fact, status: 201
    else
      render json: {
        error: "The fact entry could not be updated: #{@fact.errors.full_messages.to_sentence}"
      }, status: 400
    end
  end

  # DELETE /members/:member_id/facts/:id
  def destroy
    @fact.destroy
    render json: {
      message: "Fact ID##{@fact.id} entry successfully deleted."
    }, status: 200
  end

  private

  def fact_params
    params.require(:fact).permit(:fact_text, :likes)
  end

  def set_fact
    @fact = Fact.find(params[:id])
  end

  def set_member
    @member = Member.find(params[:member_id])
  end
end
