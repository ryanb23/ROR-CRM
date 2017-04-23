require 'test_helper'

class Admin::InsuranceFilesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get admin_insurance_files_show_url
    assert_response :success
  end

end
