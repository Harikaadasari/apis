class ProjectsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create, :update, :destroy]
  before_action :authenticate_user, only: [:create]

  def create
    user = User.find(params[:user_id])
    project = user.projects.build(project_params)

    if project.save
      render json: { project: { name: project.name, user_id: project.user_id } }
    else
      render json: { message: project.errors.full_messages.join(', ') }, status: :bad_request
    end
  end

  def index
    user = User.find(params[:user_id])
    projects = user.projects.map { |project| { id: project.id, name: project.name } }

    render json: { project_data: projects }
  end

  def show
    project = Project.find_by(id: params[:id])

    if project
      project_data = {
        name: project.name,
        collection: [
          {
            name: '',
            projectId: project.id,
            api: [
              {
                method: '',
                link: '',
                requestParams: {},
                header: {}
              }
            ]
          }
        ]
      }
      render json: { project_data: project_data }
    else
      render json: { message: "Project not found" }, status: :not_found
    end
  end

  def destroy
    project = Project.find_by(id: params[:id])

    if project
      project.destroy
      render json: { message: "Deleted successfully" }
    else
      render json: { message: "Project not found" }, status: :not_found
    end
  end

  def update
    project = Project.find_by(id: params[:id])

    if project
      project.update(name: params[:name])
      render json: { project_data: { name: project.name } }
    else
      render json: { message: "Project not found" }, status: :not_found
    end
  end

  private

  def project_params
    params.require(:project).permit(:name)
  end
end
