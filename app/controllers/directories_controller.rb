class DirectoriesController < ApplicationController

  def index
    @project = Project.find(params[:project_id])
    respond_to do |format|
      format.json { render json: @project.directories }
    end
  end

  def show
    @project = Project.find(params[:project_id])
    @directory = @project.directories.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render json: @directory }
    end
  end

  def new
    @project = Project.find(params[:project_id])
    @parent_id = params[:parent_id]
    @directory = @project.directories.new(parent_id: @parent_id)
  end

  def create
    @project = Project.find(params[:project_id])
    @directory = @project.directories.new(params[:directory])
    respond_to do |format|
      if @directory.save
        format.html{redirect_to project_directory_path(@project, @directory), notice: 'Directory was successfully created.'}
        format.json{render json: @directory}
      else
        format.html{render action: 'new'}
        format.json{render json: @directory, status: 500}
      end
    end
  end

  def edit
    @project = Project.find(params[:project_id])
    @directory = @project.directories.find(params[:id])
  end

  def update
    @project = Project.find(params[:project_id])
    @directory = @project.directories.find(params[:id])
    respond_to do |format|
      if @directory.update_attributes(params[:directory])
        format.html{redirect_to project_directory_path(@project, @directory), notice: 'Directory was successfully updated.'}
        format.json{render json: @directory}
      else
        format.html{render action: 'edit'}
        format.json{render json: @directory, status: 500}
      end
    end
  end

  def destroy
    @project = Project.find(params[:project_id])
    @directory = @project.directories.find(params[:id])
    @directory.destroy
    respond_to do |format|
      format.html{redirect_to project_path(@project), notice: 'Directory was successfully deleted.'}
      format.json{render json: {}}
    end
    
  end

  def files
    @project = Project.find(params[:project_id])
    @directory = @project.directories.find(params[:id])
    if params[:document]
      c = content_range
      @document = @directory.documents.where(
        file: CarrierWave::SanitizedFile.new(params[:document][:file]).filename,
        directory_id: @directory.id
      ).first

      if c.nil?
        if params[:document][:file].size > UPLOAD_OPTIONS[:maxChunkSize]
          # error
          render text: 'wrong request', status: 500
        else
          # ok
          @document = @directory.documents.new
          @document.file = params[:document][:file]
          @document.status = 'published'
          @document.save!
          render text: 'appended', status: 200
        end

      elsif @document.nil? && c[:range_start] == 0
        # ok
        @document = @directory.documents.new
        @document.file = params[:document][:file]
        @document.save!
        render text: 'new', status: 200
      elsif @document.nil? && c[:range_start] > 0
        # error
        render text: 'not first sequence', status: 500
      elsif @document.present? && c[:range_start] == 0
        if @document.status == 'new'
          # ok
          @document.destroy
          @document = @directory.documents.new
          @document.file = params[:document][:file]
          @document.save!
          render text: 'new', status: 200
        else
          # error
          render text: 'document exists', status: 500
        end
      elsif @document.present? && c[:range_start] > 0
        # ok
        File.open(@document.file.file.path, 'a') do |f|
          f.write(File.read(params[:document][:file].path))
        end
        @document.status = 'published' if (c[:range_total] - 1) == c[:range_end]
        @document.save!
        render text: 'appended', status: 200
      else
        # error
        render text: 'unknown error', status: 500
      end

      # todo: catch wrong sequence order

    end
  end

  def upload
    @project = Project.find(params[:project_id])
    @directory = @project.directories.find(params[:id])
    @document = @directory.documents.new
    Rails.logger.warn(params[:document]['file'])
    @document.file = params[:document]['file']
    @document.save
    @document.reload
  end

  private

  def content_range
    # bytes 0-999999/42997606
    range = request.headers['HTTP_CONTENT_RANGE']
    return nil if range.blank?
    if range =~ /^\s*bytes\s+(\d+)\s*-\s*(\d+)\/\s*(\d+)\s*$/
      return {
        range_start: $1.to_i,
        range_end:   $2.to_i,
        range_total: $3.to_i
      }
    else
      return nil
    end
  end

end
