require "test_helper"

class PostTest < ActiveSupport::TestCase
  setup do
    @user = User.create!(
      email_address: "post-test@example.com",
      password: "password",
      password_confirmation: "password",
      username: "posttest"
    )
    @post = @user.posts.create!(title: "Hello", content: "World")
  end

  test "publish sets status and published_at" do
    assert @post.publish
    assert @post.published?
    assert_not_nil @post.published_at
  end

  test "publish is idempotent" do
    published_at = Time.zone.parse("2026-01-01 12:00:00")
    @post.update!(status: :published, published_at: published_at)

    assert @post.publish
    assert_equal published_at, @post.published_at
  end

  test "unpublish clears status and published_at" do
    @post.publish

    assert @post.unpublish
    assert @post.draft?
    assert_nil @post.published_at
  end

  test "unpublish is idempotent" do
    assert @post.unpublish
    assert @post.draft?
  end
end
