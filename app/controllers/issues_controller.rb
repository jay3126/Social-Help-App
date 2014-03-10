class IssuesController < ApplicationController

	def new
		@issue = Issue.new
    params[:nav] = "add_new_project"
	end

  def index
    if current_user.ngo?
      @issues = Issue.where(category: current_user.service_type, issue_status: Constants::IssueStatusConstant.all_to_hash[:approved])
    elsif current_user.analyst?
      if params[:cat].present?
        @issues = Issue.where(category: params[:cat].split("_").map{|s| s.capitalize}.join(" "), issue_status: Constants::IssueStatusConstant.all_to_hash[:approved])
      else
        @issues = Issue.where(category: "Any Cause", issue_status: Constants::IssueStatusConstant.all_to_hash[:approved])
      end
    else
      if params[:cat].present?
        if current_user.inspector?
          @issues = Issue.where(issue_status: params[:cat].split("_").map{|s| s.capitalize}.join(" "))
        else
          @issues = Issue.where(category: params[:cat].split("_").map{|s| s.capitalize}.join(" "))
        end
      else
        @issues = Issue.where(category: "Any Cause")
      end
    end
    params[:nav] = "all_projects" unless params[:cat].present?

  end

  def create
  	@issue = Issue.new(issue_params)
  	@issue.user_id = current_user.id
  	@issue.issue_status = Constants::IssueStatusConstant.all_to_hash[:review_pending]
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

  def proposals
    issue = Issue.where(id: params[:issue_id]).first
    current_user.issues << issue
    render json: {status: 500, iss_id: params[:issue_id]}
  end

  def change_status
    issue = Issue.find_by(id: params[:id])
    if params[:status] == "q"
      status = Constants::IssueStatusConstant.all_to_hash[:approval_pending]
    elsif params[:status] == "a"
      status = Constants::IssueStatusConstant.all_to_hash[:approved]
    elsif params[:status] == "r"
      status = Constants::IssueStatusConstant.all_to_hash[:rejected]
    end
    issue.update_attribute(:issue_status, status)
    render json: {status: 200, issue_status: status}
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