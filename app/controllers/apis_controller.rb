# app/controllers/apis_controller.rb

class ApisController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    collection = Collection.find(params[:collection_id])
    apis = collection.apis
    render json: { status: 200, apis: apis }
  end

 

  def create
    collection = Collection.find(params[:collection_id])
    api_data = params[:api]

    # Ensure that the required data is present
    if api_data.blank? || !api_data.key?(:response) || !api_data.key?(:request_header) || !api_data.key?(:request_body)
      render json: { message: 'Invalid API data' }, status: :unprocessable_entity
      return
    end

    # Create the API with the user-provided data
    api = collection.apis.create(
      path: api_data[:path],
      response_template: { "response" => api_data[:response] }, # Wrap the response in a hash
      request_header: api_data[:request_header],
      request_body: api_data[:request_body],
      request_params: api_data[:request_params] || {} # Set an empty hash as default if request_params is not provided
    )

    render json: { status: 200, api: api }
  end

  
 
  def dynamic_show
    path = params[:path].start_with?('/') ? params[:path] : "/#{params[:path]}"
    api = Api.find_by(path: path)

    if api.nil?
      render json: { message: 'API not found' }, status: :not_found
      return
    end

    # Validate request parameters
    required_params = api.request_params || {}
    missing_params = required_params.keys - params.keys

    if missing_params.any?
      render json: { message: "Missing required parameters: #{missing_params.join(', ')}" }, status: :unprocessable_entity
      return
    end

    # If validation passes, proceed to generate the response dynamically
    response_template = api.response_template

    render json: response_template, status: :ok
    rescue ActiveRecord::RecordNotFound
      render json: { message: 'API not found' }, status: :not_found
    rescue JSON::ParserError
      render json: { message: 'Invalid JSON format in request body' }, status: :bad_request
  end

  def show
    collection = Collection.find(params[:collection_id])
    api = collection.apis.find_by(id: params[:id])

    if api.nil?
      render json: { message: 'API not found' }, status: :not_found
    else
      path = params[:api][:path] # Corrected to fetch the path from params[:api]
      response_template = api.response_template

      if response_template.nil?
        render json: { message: 'API does not have a valid response template' }, status: :unprocessable_entity
      else
        # Generate the dynamic response based on the response template and provided path
        dynamic_response = response_template.merge("path" => path)

        render json: { status: 200, api: dynamic_response }
      end
    end
  rescue ActiveRecord::RecordNotFound
    render json: { message: 'Collection not found' }, status: :not_found
  end
end
