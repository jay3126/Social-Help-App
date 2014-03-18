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
    @project = Project.includes(:user).find_by(id: params[:id])
    @reports = ProjectReport.includes(:project_fund).where(project_id: params[:id]).order("updated_at DESC")
    @fund_release = 0
    @percent_done = 0
    @reports.each do |p|
      if p.fund_release
        @fund_release += p.project_fund.fund_amount
        @percent_done = p.percent_done > @percent_done ? p.percent_done : @percent_done
      end
    end
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
    issue = Issue.find_by(id: params[:project][:issue_id].to_i)
    @project = Project.new
    @project.project_name = issue.issue_title
    @project.project_type = issue.category
    @project.area = issue.issue_area
    @project.project_actual_cost = params[:project][:project_actual_cost].to_i
    @project.assigned_by = current_user.id
    @project.verified_by = current_user.id
    @project.user_id = params[:project][:user_id].to_i
    @project.verified = true
    @project.project_status = Constants::ProjectStatusConstant.all_to_hash[:in_progress]
    @project.project_duration = params[:project][:project_duration].to_i
    @project.proposer_id = issue.user_id
    @project.issue_id = issue.id
    @project.save

    proposal = Proposal.find_by(id: params[:project][:prop_id])
    proposal.update(accepted: true)

    render json: {status: 500}
  end

  def ongoing_projects
    if params["spec"].present? && params["spec"] == "true"
      @ongoing_projects = Project.where(project_status: Constants::ProjectStatusConstant.all_to_hash[:in_progress], verified: true, proposer_id: current_user.id)
    else
  	  @ongoing_projects = Project.where(project_status: Constants::ProjectStatusConstant.all_to_hash[:in_progress], verified: true)
    end
    params[:cat] = "on_projects"
  end

  def completed_projects
    if params["spec"].present? && params["spec"] == "true"
      @projects = Project.where(project_status: Constants::ProjectStatusConstant.all_to_hash[:closed], verified: true, proposer_id: current_user.id)
    else
  	  @projects = Project.where(project_status: Constants::ProjectStatusConstant.all_to_hash[:closed], verified: true )
    end
    params[:cat] = "comp_projects"
  end

  def reject_project
  	issue = Issue.where(id: params[:issue_id]).first
  	issue.update(issue_status: Constants::IssueStatusConstant.all_to_hash[:rejected], rejected_on: Date.today, rejected_by: current_user.id)
    render json: {status: 500, iss_id: params[:issue_id]}
  end

  def close_project
    @project = Project.find(params[:id])
    @issue = Issue.find_by_id(params[:issue_id])
		respond_to do |format|
			if @project.update_attributes(project_status: Constants::ProjectStatusConstant.all_to_hash[:closed], closed_by: current_user.id, closed_on: Date.today)
        @issue.update(issue_status: Constants::IssueStatusConstant.all_to_hash[:closed], closed_by: current_user.id, closed_on: Date.today)
				format.html { redirect_to dashboard_path, notice: 'Project was successfully closed.' }
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

  def pending_fund
    @pending_reports = ProjectReport.includes(project: [:user]).where(status: "approved", fund_release: false)
    params[:cat] = "fund_release"
  end

  def release_fund
    res = ProjectFund.release_fund(params[:id], current_user)
    render json: res
  end

  def fund_log
    @fund_log = ProjectFundLog.includes(project: [:user]).order("created_at desc").load
    params[:cat] = "fund_log"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:project_name, :project_type, :area, :project_est_cost, :project_actual_cost, :est_start_date, :actual_start_date, :est_completion_date, :actual_completion_date, :assigned_to, :assigned_by, :verified_by, :closed_by, :project_duration, :verified, :project_status, :user_id, :issue_id, :closed_on, :approved_on)
    end
end
