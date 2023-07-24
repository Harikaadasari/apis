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

  def show
    api = Api.find(params[:id])
    render json: { status: 200, api: api }
  rescue ActiveRecord::RecordNotFound
    render json: { message: 'API not found' }, status: :not_found
  end

  private

  def api_params
    params.require(:api).permit(:name, :collection_id, :method, :path, :request_header, :request_body)
  end
end
