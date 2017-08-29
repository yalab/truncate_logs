require 'test_helper'

class TruncateLogs::ActiveRecordTest < ActiveSupport::TestCase
  include ActiveSupport::LogSubscriber::TestHelper
  def setup
    super
    ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: ':memory:')
    @old_logger = ActiveRecord::Base.logger
    ActiveRecord::Base.logger = @logger
  end

  def teardown
    ActiveRecord::Base.logger = @old_logger
  end

  def test_fixture_logs_truncate
    _1kb = SecureRandom.hex(1.kilobyte / 2)
    ActiveRecord::Base.connection.execute("SELECT '#{_1kb}'", "Fixture Insert")
    assert_match /SELECT '\[TRUNCATE 1 KB\]'/, @logger.logged(:debug).last
  end
end
