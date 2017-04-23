require 'test_helper'

class FormsControllerTest < ActionDispatch::IntegrationTest
  test "should get payment_of_analysis" do
    get forms_payment_of_analysis_url
    assert_response :success
  end

end
