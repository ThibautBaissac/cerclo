# frozen_string_literal: true

module GroupFilters
  class DateRangeFilter < BaseFilter
    def apply
      relation = apply_start_date
      apply_end_date(relation)
    end

    private

    def apply_start_date
      return relation unless params[:date_from].present?

      date_from = safe_parse_date(params[:date_from])
      return relation unless date_from

      relation.joins(:group_sessions)
              .where("group_sessions.starts_at >= ?", date_from.beginning_of_day)
              .distinct
    end

    def apply_end_date(relation)
      return relation unless params[:date_to].present?

      date_to = safe_parse_date(params[:date_to])
      return relation unless date_to

      relation.joins(:group_sessions)
              .where("group_sessions.starts_at <= ?", date_to.end_of_day)
              .distinct
    end
  end
end
