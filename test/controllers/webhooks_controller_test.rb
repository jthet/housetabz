require 'test_helper'

class WebhooksControllerTest < ActionDispatch::IntegrationTest
  test 'should get stripe' do
      mock_payload = {
      #... other Stripe payload data
      description: "user_id=5" # or whatever format you expect
    }
    get webhooks_stripe_url, params: mock_payload
    assert_response :success
  end
end
