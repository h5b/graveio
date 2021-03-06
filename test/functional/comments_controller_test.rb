require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  setup do
    sign_in users(:kmerz)
  end

  test "should create Comment" do
    @post = Post.first
    assert_difference('Comment.count') do
      post :create, :post_id => @post.id,
        comment: { body: "A welcome comment", commenter: "Franz" }
    end

    assert_not_nil(assigns(:comment))
    assert_redirected_to post_path(assigns(:post))
    assert_not_equal [], @post.comments
    assert @post.comments.any? do |c|
      c.commenter == "Franz" && c.body == "A welcome comment"
    end
  end
end
