# frozen_string_literal: true

module GroupFilters
  class TopicFilter < BaseFilter
    def apply
      return relation unless params[:topic_id].present?

      relation.where(topic_id: params[:topic_id])
    end
  end
end
