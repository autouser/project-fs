class DocumentsController < ApplicationController

  def destroy
    @project = Project.find(params[:project_id])
    @directory = @project.directories.find(params[:directory_id])
    @document = @directory.documents.find(params[:id])
    @document.destroy
    respond_to do |format|
      format.html{redirect_to project_directory_path(@project, @directory), notice: 'Document was successfully deleted.'}
      format.json{render json: {}}
    end
  end

  def show
    @project = Project.find(params[:project_id])
    @directory = @project.directories.find(params[:directory_id])
    @document = @directory.documents.find(params[:id])
    send_file(@document.file.file.file)
  end

end
