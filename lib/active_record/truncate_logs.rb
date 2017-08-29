require 'active_record'
module TruncateLogs
  module ActiveRecord
    def log(sql, name = "SQL", binds = [], type_casted_binds = [], statement_name = nil)
      sql = sql.gsub(/[^']{1024,}/) do |match|
        "[TRUNCATE #{match.bytesize.to_s(:human_size)}]"
      end
      super
    end
  end
end

ActiveRecord::ConnectionAdapters::AbstractAdapter.send(:prepend, TruncateLogs::ActiveRecord)
