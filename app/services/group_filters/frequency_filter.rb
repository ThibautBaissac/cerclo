# frozen_string_literal: true

module GroupFilters
  class FrequencyFilter < BaseFilter
    def apply
      return relation unless params[:frequency].present?

      relation.where(frequency: params[:frequency])
    end
  end
end
