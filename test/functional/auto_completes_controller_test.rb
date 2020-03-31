require File.expand_path('../../test_helper', __FILE__)

class AutoCompletesControllerTest < Redmine::ControllerTest
  fixtures :projects, :issues, :issue_statuses,
           :enumerations, :users, :issue_categories,
           :trackers,
           :projects_trackers,
           :roles,
           :member_roles,
           :members,
           :enabled_modules,
           :journals, :journal_details

  def test_should_not_be_case_sensitive
    get :mentions_users,
        params: { project_id: 'ecookbook',
                  q: 'jOhN' }

    assert_response :success
    assert_include 'John', response.body
  end

  def test_should_return_user_with_given_id
    get :mentions_users,
        params: { project_id: 'ecookbook',
                  q: '2' }

    assert_response :success
    assert_include 'John Smith', response.body
  end

  def test_without_project_should_search_all_projects
    get :mentions_users,
        params: { q: '8' }
    assert_response :success
    assert_include 'User Misc', response.body
  end

  def test_with_project_should_only_list_members
    get :mentions_users,
        params: { project_id: 'ecookbook', q: '8' }
    assert_response :success
    assert_not_include 'User Misc', response.body
  end

  def test_should_return_json
    get :mentions_users,
        params: { project_id: 'private-child',
                  q: '8' }

    assert_response :success
    json = ActiveSupport::JSON.decode(response.body)
    assert_kind_of Array, json
    user = json.first
    assert_kind_of Hash, user
    assert_equal 8, user['id']
    assert_equal 8, user['value']
    assert_equal 'User Misc - @miscuser8', user['label']
  end

  def test_auto_complete_with_user_id_should_not_return_that_user
    get :mentions_users,
        params: { q: 'dave',
                  user_id: '5' }

    assert_response :success
    assert_include 'Dave', response.body
    assert_not_include 'Dave2', response.body
  end

  def test_auto_complete_should_return_json_content_type_response
    get :mentions_users,
        params: { project_id: 'private-child',
                  q: '8' }

    assert_response :success
    assert_include 'application/json', response.headers['Content-Type']
  end
end
