# frozen_string_literal: true

module API
  module Validations
    module Types
      class LabelsList
        def self.coerce
          lambda do |value|
            case value
            when String
              value.split(',').map(&:strip)
            when Array
              value.map { |v| v.to_s.split(',').map(&:strip) }.flatten
            when LabelsList
              value
            else
              []
            end
          end
        end
      end
    end
  end
end
