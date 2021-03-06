json.array!(@projects) do |project|
  json.extract! project, :id, :project_name, :project_type, :area, :project_est_cost, :project_actual_cost, :est_start_date, :actual_start_date, :est_completion_date, :actual_completion_date, :assigned_to, :assigned_by, :verified_by, :closed_by, :project_duration
  json.url project_url(project, format: :json)
end
