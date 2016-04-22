require 'test_helper'

class PostEncouragementTest < ActiveSupport::TestCase

  test "should encourage and removeEncouragement on a post" do
    archer = users(:archer)
    post = microposts(:orange)

    # Check initial state: archer doesn't encourage post,
    # length of relationships are 0.
    assert_not archer.encourages?(post)
    assert_equal archer.encouraged.length, 0
    assert_equal post.encouragers.length, 0

    # encourage the post
    archer.encourage(post)
    assert archer.encourages?(post)    

    # Check lengths of associations are now 1 (one encouraged_post by one encourager)    
    assert_equal archer.encouraged.length, 1
    assert_equal post.reload.encouragers.length, 1

    # Remove encouragement from the post
    archer.removeEncouragement(post)
    assert_not archer.encourages?(post)

    # Check lengths of associations are again zero.
    assert_equal archer.encouraged.length, 0        
    assert_equal post.reload.encouragers.length, 0
  end
  
end
