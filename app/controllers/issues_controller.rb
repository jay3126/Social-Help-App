class IssuesController < ApplicationController

	def new
		@issue = Issues.new
	end

  def create
  	@issue = Issues.new(issue_params)
  	@issue.users_id = current_user.id
  	@issue.issue_status = 0
  	if @issue.save
  		redirect_to root_url
  	else
  		render :new
  	end
  end

  def show
  	@issue = Issues.where(id: params[:id]).first
  end

  def edit
  	@issue = Issues.where(id: params[:id]).first
  end

  def update
  	@issue = Issues.where(id: params[:id]).first
  	@issue.update(issue_params)
  	redirect_to issue_path(params[:id])
  end

  def pending_issues
  	@issues = Issues.where(users_id: current_user.id, issue_status: true)
  end

  def completed_issues
  	@issues = Issues.where(users_id: current_user.id, issue_status: false)
  	@comp = true
  end

  def profile
    @user = current_user
  end

  private
  def issue_params
  	if params[:issue].present?
	    params.require(:issue).permit(:issue_description, :issue_area, :issue_area_code)
  	else
	    params.require(:issues).permit(:issue_description, :issue_area, :issue_area_code)
  	end
 	end

end
