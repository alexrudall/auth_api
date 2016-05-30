require 'test_helper'

class GroupTest < ActiveSupport::TestCase
  def setup
    @group = groups(:one)
  end

  test 'name should be unique' do
    duplicate_group = @group.dup
    assert_not duplicate_group.valid?
  end
end
