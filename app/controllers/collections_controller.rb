
class CollectionsController < ApplicationController
  def create
  #   project = Project.find(params[:project_id])
  #   collection = project.collections.build(collection_params)
  #   if collection.save
  #     render json: { status: 200, collection: { name: collection.name, project_id: collection.project_id } }
  #   else
  #     render json: { status: 400, message: collection.errors.full_messages.join(', ') }
  #   end
  # rescue ActiveRecord::RecordNotFound
  #   render json: { status: 404, message: 'Project not found' }
  # end
  project = Project.find(params[:project_id])
    collection = project.collections.build(collection_params)
    if collection.save
      render json: { status: 200, collection: { name: collection.name, project_id: collection.project_id } }
    else
      render json: { status: 400, message: collection.errors.full_messages.join(', ') }
    end
  rescue ActiveRecord::RecordNotFound
    render json: { status: 404, message: 'Project not found' }
  end

  def index
    project = Project.find(params[:project_id])
    collections = project.collections
    render json: { status: 200, collections: collections }
  rescue ActiveRecord::RecordNotFound
    render json: { status: 404, message: 'Project not found' }
  end

  def show
    project = Project.find(params[:project_id])
    collection = project.collections.find(params[:id])
    render json: { status: 200, collection: collection }
  rescue ActiveRecord::RecordNotFound
    render json: { status: 404, message: 'Collection not found' }
  end

  def destroy
    project = Project.find(params[:project_id])
    collection = project.collections.find(params[:id])
    collection.destroy
    render json: { status: 200, message: 'Deleted successfully' }
  rescue ActiveRecord::RecordNotFound
    render json: { status: 404, message: 'Collection not found' }
  end

  private

  # def collection_params
  #   params.require(:collection).permit(:name)
  # end
  # def generate_random_name
  #   # Generate a random name using a combination of characters
  #   charset = Array('A'..'Z') + Array('a'..'z')
  #   (0...8).map { charset.sample }.join
  # end

  def collection_params
    params.require(:collection).permit(:name).merge(name: Faker::Lorem.word)
  end
end
