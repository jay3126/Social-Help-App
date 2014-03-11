class ProjectReportsController < ApplicationController

	def create
		@project_report = ProjectReport.new(report_params)
		@project_report.user_id = current_user.id
		if @project_report.save
			project = Project.find_by(id: @project_report.project_id)
			report_log = ProjectReportLog.new
			report_log.project_id = @project_report.project_id
			report_log.user_id = current_user.id
			report_log.action = "Report Submitted"
			report_log.desc = "#{current_user.name} submitted project report for #{project.project_name}"
			report_log.project_report_id = @project_report.id
			report_log.save
		else
			@my_projects = Project.where(user_id: current_user.id)
			@project_report = ProjectReport.new
			params[:nav] = "my_project"
			@report_error = "error"
			render action: "users/my_projects"
		end
		redirect_to dashboard_url
	end

	private
	def report_params
		params.require(:project_report).permit(:project_id, :percent_done, :remarks)
	end

end
