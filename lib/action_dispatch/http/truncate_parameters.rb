require "active_support/concern"
require "action_dispatch"

module ActionDispatch
  module Http
    module TruncateParameters
      def filtered_parameters
        params_truncate super
      end

      def params_truncate(original_params)
        truncated_params = original_params.class.new
        original_params.each do |k, v|
          truncated_params[k] = if v.is_a?(Hash)
                                    params_truncate(v)
                                  else
                                    truncate(v)
                                  end
        end
        truncated_params
      end

      def truncate(value)
        bytesize = value.bytesize
        if bytesize >= 1.kilobyte
          "[TRUNCATE #{bytesize.to_s(:human_size)}]"
        else
          value
        end
      end
    end
  end
end

ActionDispatch::Request.include ActionDispatch::Http::TruncateParameters
