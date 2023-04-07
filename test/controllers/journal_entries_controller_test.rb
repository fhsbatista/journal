require "test_helper"

class JournalEntriesControllerTest < ActionController::TestCase
  def test_index_returns_success
    get :index
    assert_response :success
  end
end
