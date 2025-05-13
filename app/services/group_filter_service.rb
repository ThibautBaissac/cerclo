# frozen_string_literal: true

class GroupFilterService < FilterService
  def initialize(params = {})
    super(params)
    @relation = Group.all.includes(:topic, :facilitator)
  end

  def call
    apply_filters
    @relation
  end

  private

  def apply_filters
    filters.each do |filter|
      @relation = filter.new(@relation, params).apply
    end
  end

  def filters
    [
      GroupFilters::TopicFilter,
      GroupFilters::CategoryFilter,
      GroupFilters::FrequencyFilter,
      GroupFilters::AvailabilityFilter,
      GroupFilters::DateRangeFilter
    ]
  end
end
