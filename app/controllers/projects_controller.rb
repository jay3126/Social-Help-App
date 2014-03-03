class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.all
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)
    @project.est_start_date = params[:est_start_date]
    @project.actual_start_date = params[:actual_start_date]
    @project.est_completion_date = params[:est_completion_date]
    @project.actual_completion_date = params[:actual_completion_date]
    @project.project_status = "In Progress"
    @project.assigned_by = current_user.id
    @project.verified_by = current_user.id
    @project.user_id = current_user.id

    respond_to do |format|
      if @project.save
      	issue = Issue.find_by_id(params[:issue_id])
      	issue.update(is_approved: true) if issue.present?  #setting the is_approved flag to true in Issues table.
        format.html { redirect_to pending_proposed_projects_projects_path, notice: 'Project was successfully approved.' }
        format.json { render action: 'show', status: :created, location: @project }
      else
        format.html { render action: 'new' }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def pending_proposed_projects
  	@project = Project.new
  	@pending_proposed_projects = Issue.where(issue_status: true, is_approved: false)
  end

  def pending_projects
  	@projects = Project.where(project_status: "In Progress")
  end

  def completed_projects
  	@projects = Project.where(project_status: "Closed")
  	@comp = true
  end

  def close_project
    @project = Project.find(params[:id])
		respond_to do |format|
			if @project.update_attributes(project_status: "Closed", closed_by: current_user.id)
				format.html { redirect_to pending_projects_projects_path, notice: 'Project was successfully closed.' }
				format.json { head :no_content }
			else
				format.html { render action: 'edit' }
				format.json { render json: @project.errors, status: :unprocessable_entity }
			end
		end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:project_name, :project_type, :area, :project_est_cost, :project_actual_cost, :est_start_date, :actual_start_date, :est_completion_date, :actual_completion_date, :assigned_to, :assigned_by, :verified_by, :closed_by, :project_duration, :verified, :project_status)
    end
end
