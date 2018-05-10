module Dry
  module Types
    module Coercions
      include Dry::Core::Constants

      # @param [String, Object] input
      # @return [nil] if the input is an empty string
      # @return [Object] otherwise the input object is returned
      def to_nil(input)
        input unless empty_str?(input)
      end

      # @param [#to_str, Object] input
      # @return [Date, Object]
      # @see Date.parse
      def to_date(input)
        return input unless input.respond_to?(:to_str)
        Date.parse(input)
      rescue ArgumentError, RangeError
        input
      end

      # @param [#to_str, Object] input
      # @return [DateTime, Object]
      # @see https://github.com/rails/rails/blob/2161b78336bb9c2b169063c22af10485ff9a93e7/activesupport/lib/active_support/core_ext/string/zones.rb#L9
      def to_date_time(input)
        return input unless input.respond_to?(:to_str)
        # @note in_time_zone maybe returns nil
        input.to_str.in_time_zone&.to_datetime || input
      end

      # @param [#to_str, Object] input
      # @return [Time, Object]
      # @see https://github.com/rails/rails/blob/2161b78336bb9c2b169063c22af10485ff9a93e7/activesupport/lib/active_support/core_ext/string/zones.rb#L9
      def to_time(input)
        return input unless input.respond_to?(:to_str)
        # @note in_time_zone maybe returns nil
        input.to_str.in_time_zone || input
      end

      private

      # Checks whether String is empty
      # @param [String, Object] value
      # @return [Boolean]
      def empty_str?(value)
        EMPTY_STRING.eql?(value)
      end
    end
  end
end
