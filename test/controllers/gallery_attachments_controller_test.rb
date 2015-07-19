require 'test_helper'

class GalleryAttachmentsControllerTest < ActionController::TestCase
  setup do
    @gallery_attachment = gallery_attachments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:gallery_attachments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create gallery_attachment" do
    assert_difference('GalleryAttachment.count') do
      post :create, gallery_attachment: { gallery_id: @gallery_attachment.gallery_id, image: @gallery_attachment.image }
    end

    assert_redirected_to gallery_attachment_path(assigns(:gallery_attachment))
  end

  test "should show gallery_attachment" do
    get :show, id: @gallery_attachment
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @gallery_attachment
    assert_response :success
  end

  test "should update gallery_attachment" do
    patch :update, id: @gallery_attachment, gallery_attachment: { gallery_id: @gallery_attachment.gallery_id, image: @gallery_attachment.image }
    assert_redirected_to gallery_attachment_path(assigns(:gallery_attachment))
  end

  test "should destroy gallery_attachment" do
    assert_difference('GalleryAttachment.count', -1) do
      delete :destroy, id: @gallery_attachment
    end

    assert_redirected_to gallery_attachments_path
  end
end
