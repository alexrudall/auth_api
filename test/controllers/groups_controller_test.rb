require 'test_helper'

class GroupsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @group = groups(:one)
    @user = users(:admin)
    @token = AuthenticateUser.call(@user.email, 'password').result
  end

  test "should get index" do
    get groups_url, headers: { authorization: @token }
    assert_response :success
  end

  test "should create group" do
    assert_difference('Group.count') do
      post groups_url, params: { group: { name: 'New Group' } }, headers: { authorization: @token }
    end

    assert_response 201
  end

  test "should show group" do
    get group_url(@group), headers: { authorization: @token }
    assert_response :success
  end

  test "should update group" do
    patch group_url(@group), params: { group: { name: 'New Name :)' } }, headers: { authorization: @token }
    assert_response 200
  end

  test "should destroy group" do
    assert_difference('Group.count', -1) do
      delete group_url(@group), headers: { authorization: @token }
    end

    assert_response 204
  end
end
