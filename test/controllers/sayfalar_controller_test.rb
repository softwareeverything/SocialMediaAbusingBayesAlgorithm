require 'test_helper'

class SayfalarControllerTest < ActionDispatch::IntegrationTest
  test "should get anasayfa" do
    get sayfalar_anasayfa_url
    assert_response :success
  end

end
