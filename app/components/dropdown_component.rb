# frozen_string_literal: true

class DropdownComponent < ViewComponent::Base
  POSITIONS = %w[top top-start top-end right right-start right-end bottom bottom-start bottom-end left left-start left-end]

  renders_one :button
  renders_one :leader
  renders_many :items, -> (css: nil, &block) do
    content_tag :li, role: "menuitem", class: class_names("[&>*]:block [&>*]:px-3 [&>*]:py-1.5 [&>*]:truncate", {"text-gray-700 [&>a]:hover:bg-gray-50": @theme.light?, "text-gray-200 [&>a]:hover:bg-gray-900": @theme.dark?}, css), &block
  end
  renders_one :trailer

  def initialize(theme: "light", position: "bottom-start", offset: 2, padding: nil, data_transitions: {}, container_css: nil)
    @theme = theme.inquiry
    @position = position
    @offset = offset
    @padding = padding
    @data_transitions = data_transitions
    @container_css = container_css

    raise StandardError.new("Incorrect position. Should be one of: #{POSITIONS.to_sentence(last_word_connector: " or ")}") if POSITIONS.exclude? position
  end

  def content_min_max_width
    "min-w-[8rem] max-w-[16rem]"
  end

  def container_css
    @container_css.presence || "relative"
  end

  def menu_data
    {turbo_temporary: "", dropdown_target: "menu"}.merge(data_transitions)
  end

  def menu_css
    class_names(
      "absolute mt-1 text-sm shadow-xl overflow-x-hidden rounded-lg z-10",
      content_min_max_width,
      "max-h-60 overflow-y-auto", # max height: 240px
      @padding,
      {
        "bg-white ring-1 ring-inset ring-gray-100/50 backdrop-blur-md": @theme.light?,
        "bg-gray-800": @theme.dark?
      }
    )
  end

  private

  def data_transitions
    @data_transitions.presence || {
      transition_enter: "transition ease-out duration-100", # Base classes for “showing” the menu
      transition_enter_start: "opacity-0 -translate-y-2",   # The initial classes before “showing” the menu
      transition_enter_end: "opacity-100 translate-y-0",    # The final classes before “showing” the menu
      transition_leave: "transition ease-in duration-75",   # Base classes for “hiding” the menu
      transition_leave_start: "opacity-100 translate-y-0",  # The initial class before “hiding” the menu
      transition_leave_end: "opacity-0 -translate-y-2",     # The final classes before “hiding” the menu
    }
  end
end
