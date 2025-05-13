# frozen_string_literal: true

class FilterService
  attr_reader :params

  def initialize(params = {})
    @params = params
  end

  def call
    raise(NotImplementedError, "#{self.class} must implement the call method")
  end

  protected

  def apply_filters
    available_filters.each do |filter|
      send(filter) if respond_to?(filter, true)
    end
  end

  def available_filters
    []
  end

  def safe_parse_date(date_string)
    Date.parse(date_string)
  rescue StandardError
    nil
  end
end
