class IssuesController < ApplicationController

	def new
		@issue = Issue.new
    params[:nav] = "add_new_project"
	end

  def index
    @issues = Issue.all
    params[:nav] = "all_projects"
  end

  def create
  	@issue = Issue.new(issue_params)
  	@issue.user_id = current_user.id
  	@issue.issue_status = Constants::IssueStatusConstant.all_to_hash[:open]
  	if @issue.save
  		redirect_to root_url
  	else
  		render :new
  	end
  end

  def show
  	@issue = Issue.where(id: params[:id]).first
  end

  def edit
  	@issue = Issue.where(id: params[:id]).first
  end

  def update
  	@issue = Issue.where(id: params[:id]).first
  	@issue.update(issue_params)
  	redirect_to issue_path(params[:id])
  end

  def interested_ngos
    issue = Issue.where(id: params[:issue_id]).first
    current_user.issues << issue
    render json: {status: 500, iss_id: params[:issue_id]}
  end

  private
  def issue_params
  	if params[:issue].present?
	    params.require(:issue).permit(:issue_description, :issue_area, :issue_area_code, :issue_status, :project_est_cost, :user_id, :issue_title, :closed_by, :rejected_by, :rejected_on, :closed_on, :category)
  	else
	    params.require(:issues).permit(:issue_description, :issue_area, :issue_area_code, :issue_status, :project_est_cost, :user_id, :issue_title, :closed_by, :rejected_by, :rejected_on, :closed_on, :category)
  	end
 	end

end