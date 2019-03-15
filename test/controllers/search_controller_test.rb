# frozen_string_literal: true

require 'test_helper'

class SearchControllerTest < ActionDispatch::IntegrationTest
  it 'renders search page' do
    get root_path

    assert_response :success
  end
end
