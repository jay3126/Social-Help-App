class IssuesController < ApplicationController

	def new
		@issue = Issue.new
	end

  def index
    @issues = Issue.all
  end

  def create
  	@issue = Issue.new(issue_params)
  	@issue.users_id = current_user.id
  	@issue.issue_status = 0
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

  def pending_issues
  	@issues = Issue.where(users_id: current_user.id, issue_status: true)
  end

  def completed_issues
  	@issues = Issue.where(users_id: current_user.id, issue_status: false)
  	@comp = true
  end

  def interested_ngos
    issue = Issue.where(id: params[:issue_id]).first
    current_user.issues << issue
  end

  private
  def issue_params
  	if params[:issue].present?
	    params.require(:issue).permit(:issue_description, :issue_area, :issue_area_code, :issue_status, :project_est_code, :users_id)
  	else
	    params.require(:issues).permit(:issue_description, :issue_area, :issue_area_code, :issue_status, :project_est_code, :users_id)
  	end
 	end

end
