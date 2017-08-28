require 'test_helper'

class TruncateLogsTestController < ActionController::Base
  def index
    head :ok
  end
end

class TruncateLogs::ActionControllerTest < ActionController::TestCase
  tests TruncateLogsTestController
  include ActiveSupport::LogSubscriber::TestHelper

  def setup
    super
    @routes = ActionDispatch::Routing::RouteSet.new
    @routes.draw do
      resources :truncate_logs_test
    end
    @old_logger = ActionController::Base.logger
    ActionController::LogSubscriber.attach_to :action_controller
  end

  def teardown
    super
    ActiveSupport::LogSubscriber.log_subscribers.clear
    ActionController::Base.logger = @old_logger
  end

  def set_logger(logger)
    ActionController::Base.logger = logger
  end

  def test_log_truncate
    _1kb = SecureRandom.hex(1.kilobyte / 2)
    _1mb = SecureRandom.hex(1.megabyte / 2)
    get :index, params: {kb: _1kb, nest1: {nest2: _1mb}}
    wait
    assert_match /1 KB/, logs[1]
    assert_match /1 MB/, logs[1]
  end

  def logs
    @logs ||= @logger.logged(:info)
  end
end
