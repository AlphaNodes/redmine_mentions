require File.expand_path('../../test_helper', __FILE__)

class RoutingTest < Redmine::RoutingTest
  test 'routing auto completes' do
    should_route 'GET /auto_completes/mentions_users' => 'auto_completes#mentions_users'
  end
end
