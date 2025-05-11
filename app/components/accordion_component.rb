# frozen_string_literal: true

class AccordionComponent < ViewComponent::Base
  renders_one :closed_icon
  renders_one :opened_icon
  renders_one :trailer, ->(css: "", &block) do
    content_tag(:span, class: css, &block)
  end

  renders_many :items, ->(summary:, trailer_text: nil, css: nil, &block) do
    content_tag(:details, {class: "group marker:content-['']"}.merge(attributes)) do
      summary_content = tag.p(class: "flex items-center justify-between w-full") do
        concat(summary)
        concat(tag.span(trailer_text, class: @trailer_css)) if trailer_text.present?
      end

      concat(content_tag(:summary, summary_content.concat(closed_icon.to_s).concat(opened_icon.to_s).html_safe, class: class_names("flex items-center gap-2 cursor-pointer select-none [&::-webkit-details-marker]:hidden", css)))

      concat(capture(&block))
    end
  end

  def initialize(wrapper_css: nil, trailer_css: nil, open: false, name: nil)
    @wrapper_css = wrapper_css
    @trailer_css = trailer_css
    @open = open
    @name = name
  end

  private

  def attributes
    open_attribute.merge(name_attribute)
  end

  def open_attribute = @open ? {open: ""} : {}

  def name_attribute = {name: @name}.compact_blank!
end
