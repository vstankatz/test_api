class QuotesController < ApplicationController
before_action :authenticate_user!, only: [:create, :update, :destroy]
  def index
    name = params[:name]
    if params[:name].blank?
      @quotes = Quote.all
      json_response(@quotes)
    else
      @parameter = params[:name].downcase
      @quotes = Quote.all.where("lower(author) ILIKE :search", search: "%#{@parameter}%")
      json_response(@quotes)
    end
    end

    def show
      binding.pry
      @quote = Quote.find(params[:id])
      json_response(@quote)
    end

    def create
      @quote = Quote.create!(quote_params)
      json_response(@quote, :created)
    end

    def update
      @quote = Quote.find(params[:id])
      if @quote.update!(quote_params)
        render status: 200, json: {
          message: "This quote has been updated successfully."
          }
      end
    end

    def destroy
      @quote = Quote.find(params[:id])
      if @quote.destroy
        render status: 200, json: {
          message: "This quote has been deleted."
        }
      end
    end

    private
    def json_response(object, status = :ok)
      render json: object, status: status
    end

    def quote_params
      params.permit(:author, :content)
    end

end
