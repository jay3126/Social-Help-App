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
		end
	end

	def issue_actions(iss)
		opt = ""
		if iss.user_id == current_user.id
			if iss.issue_status == Constants::IssueStatusConstant.all_to_hash[:open]
				opt << "<a href=#{edit_issue_path(id: iss.id)} class='btn btn-xs btn-danger'  data-rel='tooltip' title='' data-original-title='Edit Project'><i class='icon-edit bigger-120'></i></a>"
			end
		end

		if current_user.role == "NGO"
			opt << '<a id="int_btn_<%= iss.id%>" onClick="return sendProposal(<%= iss.id %>);" class="btn btn-xs btn-info" data-rel="tooltip" title="" data-original-title="Send Proposal"><i class="icon-download-alt bigger-120"></i></a>'
		end

		if current_user.role == "Analyst"
			opt << "<a href=#{proposals_path(issue_id: iss.id)} class='btn btn-xs btn-info' data-rel='tooltip' title='' data-original-title='See Proposals'><i class='icon-download-alt bigger-120'></i></a>"
		end

		opt
	end

end
