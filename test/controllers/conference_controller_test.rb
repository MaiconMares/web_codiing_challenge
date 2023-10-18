require 'test_helper'

class SchedulingsControllerTest < ActionDispatch::IntegrationTest
  
  test 'should show add button and add new conference' do
    get root_path
    assert_response :success

    assert_select "button", text: "Adicionar"

    conference = conferences(:one)
    assert_difference 'Conference.count', 1 do
      post "/conferences", params: { conference: {name: conference.name, duration: conference.duration}}
    end
  end
end