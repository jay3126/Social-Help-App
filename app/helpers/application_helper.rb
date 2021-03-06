module ApplicationHelper

	def render_panel(role)
		case role.downcase
		when "corporate"
			render partial: "navs/corp_left_panel"
		when "socialist"
			render partial: "navs/socialist_left_panel"
		when "ngo"
			render partial: "navs/ngo_left_panel"
		when "analyst"
			render partial: "navs/analyst_left_panel"
		when "inspector"
			render partial: "navs/inspector_left_panel"
		when "donor"
			render partial: "navs/donor_left_panel"
		end
	end

	def render_profile(role)
		case role.downcase
		when "corporate"
			render partial: "corporate_profile"
		when "socialist"
			render partial: "socialist_profile"
		when "ngo"
			render partial: "ngo_profile"
		when "analyst"
			render partial: "analyst_profile"
		when "inspector"
			render partial: "inspector_profile"
		when "donor"
			render partial: "donor_profile"
		end
	end

	def render_dashboard(role)
		case role.downcase
		when "corporate"
			render partial: "corporate_dashboard"
		when "socialist"
			render partial: "socialist_dashboard"
		when "ngo"
			render partial: "ngo_dashboard"
		when "analyst"
			render partial: "analyst_dashboard"
		when "inspector"
			render partial: "inspector_dashboard"
		when "donor"
			render partial: "donor_dashboard"
		end
	end

	def issue_actions(iss)
		opt = ""
		if iss.user_id == current_user.id
			if iss.issue_status == Constants::IssueStatusConstant.all_to_hash[:review_pending]
				opt << "<a href=#{edit_issue_path(id: iss.id)} class='btn btn-xs btn-danger'  data-rel='tooltip' title='' data-original-title='Edit Issue'><i class='icon-edit bigger-120'></i></a>"
			end
		end

		if current_user.ngo? && iss.issue_status == Constants::IssueStatusConstant.all_to_hash[:approved] && iss.category == current_user.service_type
			unless iss.users.all.include?(current_user) 
				opt << "<a onClick='return sendProposal(#{iss.id});' class='btn btn-xs btn-info' data-rel='tooltip' title='' data-original-title='Send Proposal'><i class='icon-download-alt bigger-120'></i></a>"
			else
				opt << "<a onClick='return false' class='btn btn-xs btn-info non-click' data-rel='tooltip' title='' data-original-title='Proposal Sent'><i class='icon-download-alt bigger-120 non-click'></i></a>"
			end
		end

		if current_user.inspector?
			if iss.issue_status == Constants::IssueStatusConstant.all_to_hash[:review_pending]
				opt << "<a href='' id='approve_pending_#{iss.id}' onClick='return changeStatus(#{iss.id},\"q\");' class='btn btn-xs' data-rel='tooltip' title='' data-original-title='Queue for Approval'><i class='icon-check bigger-120'></i></a>"
				opt << "<a href='' id='reject_#{iss.id}' onClick='return changeStatus(#{iss.id},\"r\");' class='btn btn-xs btn-danger' data-rel='tooltip' title='' data-original-title='Reject Issue'><i class='icon-ban-circle bigger-120'></i></a>"
			elsif iss.issue_status == Constants::IssueStatusConstant.all_to_hash[:approval_pending]
				opt << "<a href='' id='approve_#{iss.id}' onClick='return changeStatus(#{iss.id},\"a\");' class='btn btn-xs' data-rel='tooltip' title='' data-original-title='Approve Issue'><i class='icon-check bigger-120'></i></a>"
				opt << "<a href='' id='reject_#{iss.id}' onClick='return changeStatus(#{iss.id},\"r\");' class='btn btn-xs btn-danger' data-rel='tooltip' title='' data-original-title='Reject Issue'><i class='icon-ban-circle bigger-120'></i></a>"					
			end
		end

		if current_user.analyst?
			opt << "<a href=#{proposals_path(issue_id: iss.id)} class='btn btn-xs btn-info' data-rel='tooltip' title='' data-original-title='See Proposals'><i class='icon-download-alt bigger-120'></i></a>"
		end

		opt
	end

	def render_tabs(role)
		case role.downcase
		when "corporate"
			render partial: "corporate_tabs"
		when "socialist"
			render partial: "socialist_tabs"
		when "ngo"
			render partial: "ngo_tabs"
		when "analyst"
			render partial: "analyst_tabs"
		when "inspector"
			render partial: "inspector_tabs"
		when "donor"
			render partial: "donor_tabs"
		end
	end

	def render_profile_details(role)
		case role.downcase
		when "corporate"
			render partial: "corporate_details"
		when "socialist"
			render partial: "socialist_details"
		when "ngo"
			render partial: "ngo_details"
		when "analyst"
			render partial: "analyst_details"
		when "inspector"
			render partial: "inspector_details"
		when "donor"
			render partial: "donor_details"
		end
	end

end
