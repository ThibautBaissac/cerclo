# frozen_string_literal: true

module GroupFilters
  class BaseFilter
    attr_reader :relation, :params

    def initialize(relation, params = {})
      @relation = relation
      @params = params
    end

    def apply
      raise NotImplementedError, "#{self.class} must implement the apply method"
    end

    protected

    def safe_parse_date(date_string)
      Date.parse(date_string)
    rescue StandardError
      nil
    end
  end
end
