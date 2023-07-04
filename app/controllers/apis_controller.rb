class ApisController < ApplicationController
  protect_from_forgery with: :null_session
  def index
    collection = Collection.find(params[:collection_id])
    apis = collection.apis
    render json: { status: 200, apis: apis }
  end

  def create
    collection = Collection.find(params[:collection_id])
    api = collection.apis.create(api_params)
    render json: { status: 200, api: api }
  end
  #   50.times do
  #   Api.create(
  #     name: Faker::Lorem.word,
  #     collection_id: Faker::Alphanumeric.alphanumeric(number: 10),
  #     method: ['GET', 'POST', 'PUT', 'DELETE'].sample,
  #     path: Faker::Internet.url,
  #     requestheader: Faker::Lorem.sentence,
  #     requestbody: Faker::Lorem.sentence
  #   )
  #   api = collection.apis.create(api_params)
  #   render json: { status: 200, api: api }
  # end
  # end 
  private

   def api_params
    params.require(:api).permit(:name, :collection_id, :method, :path, :request_header, :request_body)
  end
end
