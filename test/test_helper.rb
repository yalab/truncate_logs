$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "truncate_logs"

require "minitest/autorun"
require "action_controller"
require "active_support/log_subscriber/test_helper"
require "active_support/core_ext/numeric"
