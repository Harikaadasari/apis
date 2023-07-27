class CollectionsController < ApplicationController
   before_action :find_project
  skip_before_action :verify_authenticity_token


  def create
    collection = @project.collections.build(collection_params)
    if collection.save
      render json: { collection: { name: collection.name, project_id: collection.project_id } }
    else
      render json: { message: collection.errors.full_messages.join(', ') }, status: :bad_request
    end
  end

  def index
    collections = @project.collections
    render json: { collections: collections }
  end

  def show
    collection = @project.collections.find(params[:id])
    render json: { collection: collection }
  rescue ActiveRecord::RecordNotFound
    render json: { message: 'Collection not found' }, status: :not_found
  end

  def destroy
    collection = @project.collections.find(params[:id])
    collection.destroy
    render json: { message: 'Deleted successfully' }
  rescue ActiveRecord::RecordNotFound
    render json: { message: 'Collection not found' }, status: :not_found
  end

  private

  def find_project
    @project = Project.find(params[:project_id])
  rescue ActiveRecord::RecordNotFound
    render json: { message: 'Project not found' }, status: :not_found
  end

  def collection_params
    params.require(:collection).permit(:name)
  end
end
