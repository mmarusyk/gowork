require 'test_helper'

class ProposalsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @proposal = proposals(:one)
    @order = orders(:one)
  end

  test 'should redirect create when not logged in' do
    assert_no_difference 'Proposal.count' do
      post proposals_path, params: {
        content: 'To Do it very quick',
        price: 2000.50,
        duedate: '11.07.2020',
        order_id: @order.id
      }
    end
    assert_redirected_to login_url
  end

  test 'should redirect destroy when not logged in' do
    assert_no_difference 'Proposal.count' do
      delete proposal_path(@proposal)
    end
    assert_redirected_to login_url
  end
end
