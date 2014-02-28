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
			render partial: "dashboard"
		end
	end

end
