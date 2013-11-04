class ProjectsController < ApplicationController

  def index
    @projects = Project.order(:name)
    respond_to do |format|
      format.html
      format.json { render json: @projects }
    end
    
  end

  def show
    @project = Project.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render json: @project }
    end
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(params[:project])
    respond_to do |format|
      if @project.save
        format.html{redirect_to edit_project_path(@project), notice: 'Project was successfully created.'}
        format.json{render json: @project}
      else
        format.html{render action: 'new'}
        format.json{render json: @project, status: 500}
      end      
    end
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html{redirect_to edit_project_path(@project), notice: 'Project was successfully updated.'}
        format.json{render json: @project}
      else
        format.html{render action: 'edit'}
        format.json{render json: @project, status: 500}
      end
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    respond_to do |format|
      format.html{redirect_to projects_path, notice: 'Project was successfully deleted.'}
      format.json{render json: {}}
    end
  end

end
