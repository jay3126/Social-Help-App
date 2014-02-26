require 'test_helper'

class ProjectsControllerTest < ActionController::TestCase
  setup do
    @project = projects(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:projects)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create project" do
    assert_difference('Project.count') do
      post :create, project: { actual_completion_date: @project.actual_completion_date, actual_start_date: @project.actual_start_date, area: @project.area, assigned_by: @project.assigned_by, assigned_to: @project.assigned_to, closed_by: @project.closed_by, est_completion_date: @project.est_completion_date, est_start_date: @project.est_start_date, project_actual_cost: @project.project_actual_cost, project_duration: @project.project_duration, project_est_cost: @project.project_est_cost, project_name: @project.project_name, project_type: @project.project_type, verified_by: @project.verified_by }
    end

    assert_redirected_to project_path(assigns(:project))
  end

  test "should show project" do
    get :show, id: @project
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @project
    assert_response :success
  end

  test "should update project" do
    patch :update, id: @project, project: { actual_completion_date: @project.actual_completion_date, actual_start_date: @project.actual_start_date, area: @project.area, assigned_by: @project.assigned_by, assigned_to: @project.assigned_to, closed_by: @project.closed_by, est_completion_date: @project.est_completion_date, est_start_date: @project.est_start_date, project_actual_cost: @project.project_actual_cost, project_duration: @project.project_duration, project_est_cost: @project.project_est_cost, project_name: @project.project_name, project_type: @project.project_type, verified_by: @project.verified_by }
    assert_redirected_to project_path(assigns(:project))
  end

  test "should destroy project" do
    assert_difference('Project.count', -1) do
      delete :destroy, id: @project
    end

    assert_redirected_to projects_path
  end
end
