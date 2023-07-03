
class ProjectsController < ApplicationController
  def create
    # Generate random project data
    project_name = Faker::Company.name

    # Create the project
    project = Project.create(name: project_name)

    if project.persisted?
      render json: { status: 200, project_data: { name: project.name } }
    else
      render json: { status: 500, message: "Error creating project" }
    end
  end

  def index
    projects = Project.all.map { |project| { id: project.id, name: project.name } }

    render json: { status: 200, project_data: projects }
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
      render json: { status: 200, project_data: project_data }
    else
      render json: { status: 404, message: "Project not found" }
    end
  end

  def destroy
    project = Project.find_by(id: params[:id])

    if project
      project.destroy
      render json: { status: 200, message: "Deleted successfully" }
    else
      render json: { status: 404, message: "Project not found" }
    end
  end

  def update
    project = Project.find_by(id: params[:id])

    if project
      project.update(name: params[:name])
      render json: { status: 200, project_data: { name: project.name } }
    else
      render json: { status: 404, message: "Project not found" }
    end
  end
end
