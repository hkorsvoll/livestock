require 'test_helper'

class NotesControllerTest < ActionController::TestCase
  setup do
    @note = messages(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:notes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create message" do
    assert_difference('Message.count') do
      post :create, :note => { :category_id => @note.category_id, :date_from => @note.date_from, :date_to => @note.date_to, :note => @note.note }
    end

    assert_redirected_to message_path(assigns(:note))
  end

  test "should show message" do
    get :show, :id => @note
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @note
    assert_response :success
  end

  test "should update message" do
    put :update, :id => @note, :note => { :category_id => @note.category_id, :date_from => @note.date_from, :date_to => @note.date_to, :note => @note.note }
    assert_redirected_to message_path(assigns(:note))
  end

  test "should destroy message" do
    assert_difference('Message.count', -1) do
      delete :destroy, :id => @note
    end

    assert_redirected_to messages_path
  end
end
