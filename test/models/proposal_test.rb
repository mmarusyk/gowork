require 'test_helper'

class ProposalTest < ActiveSupport::TestCase
  def setup
    @user = users(:misha)
    @order = orders(:one)
    @proposal = @user.proposals.build(
      content: 'To Do it very quick',
      price: 2000.50,
      duedate: '11.07.2020',
      order_id: @order.id
    )
  end

  test 'should be valid' do
    assert @proposal.valid?
  end

  test 'user id should be present' do
    @proposal.user_id = nil
    assert_not @proposal.valid?
  end

  test 'order id should be present' do
    @proposal.order_id = nil
    assert_not @proposal.valid?
  end

  test 'content should be at most 5000 characters' do
    @proposal.content = 'a' * 5001
    assert_not @proposal.valid?
  end

  test 'proposal should be most recent first' do
    assert_equal proposals(:most_recent), Proposal.first
  end
end
