require 'test_helper'

class Admin::UserSkillsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get admin_user_skills_show_url
    assert_response :success
  end

  test "should get destroy" do
    get admin_user_skills_destroy_url
    assert_response :success
  end

end
