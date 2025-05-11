# frozen_string_literal: true

class NavbarComponent < ViewComponent::Base
  renders_one :logo
  renders_many :links, ->(current_page: false, &block) do
    content_tag(:li, class: link_css(current_page: current_page), &block)
  end
  renders_one :primary_action
  renders_many :secondary_links, ->(&block) do
    content_tag(:li, class: "block", &block)
  end

  def initialize(theme: "light", menu_position: "left")
    @theme, @menu_position = theme.inquiry, menu_position
  end

  def container_css
    class_names(
      "flex items-center p-2 group/navigation fixed w-full top-0 left-0 z-100",
      {
        "bg-gray-800 text-white": @theme.dark?,
        "bg-white text-gray-600": @theme.light?
      }
    )
  end

  def menu_items_css
    class_names(
      "hidden grow w-full rounded-md max-md:absolute max-md:left-0 max-md:top-full max-md:px-2 max-md:py-4 max-md:flex-col max-md:gap-3 max-md:border max-md:shadow-xl max-md:z-10 md:flex md:items-center md:justify-end group-data-[show-menu]/navigation:flex",
      {
        "bg-gray-800 text-white border-gray-700": @theme.dark?,
        "bg-white text-gray-600 border-gray-100": @theme.light?
      }
    )
  end

  def links_css
    class_names(
      "flex flex-col items-center gap-4 max-md:w-full md:flex-row md:gap-6 text-center",
      {
        "md:ml-2": @menu_position == "left",
        "mx-auto": @menu_position == "center",
        "md:ml-auto md:justify-end": @menu_position == "right"
      }
    )
  end

  private

  def link_css(current_page: false)
    class_names(
      "w-full [&>a]:flex [&>a]:items-center [&>a]:justify-center [&>a]:px-4 [&>a]:py-2 [&>a]:w-full [&>a]:text-base [&>a]:font-semibold [&>a]:rounded-md [&>a]:max-md:py-3 [&>a]:text-center",
      {
        "[&>a]:hover:text-gray-800 [&>a]:hover:bg-gray-100": @theme.light? && !current_page,
        "[&>a]:hover:text-gray-100 [&>a]:hover:bg-gray-950": @theme.dark? && !current_page,
        "[&>a]:text-indigo-500 [&>a]:bg-indigo-50 [&>a]:hover:text-indigo-500 [&>a]:hover:bg-indigo-50": current_page && @theme.light?,
        "[&>a]:text-indigo-300 [&>a]:bg-indigo-900/60 [&>a]:hover:text-indigo-300 [&>a]:hover:bg-indigo-900/60": current_page && @theme.dark?
      }
    )
  end
end
