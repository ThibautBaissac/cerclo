# frozen_string_literal: true

module GroupFilters
  class CategoryFilter < BaseFilter
    def apply
      return relation unless params[:category].present?

      relation.joins(:topic).where(topics: { category: params[:category] })
    end
  end
end
