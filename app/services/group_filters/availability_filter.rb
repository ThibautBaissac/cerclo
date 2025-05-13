# frozen_string_literal: true

module GroupFilters
  class AvailabilityFilter < BaseFilter
    def apply
      return relation unless params[:availability].present?

      case params[:availability]
      when "available"
        relation.select(&:spots_available?)
      when "full"
        relation.select(&:full?)
      else
        relation
      end
    end
  end
end
