module ApplicationHelper
  def back_button(text, link)
    button_text = content_tag("i", "", :class => 'icon-chevron-left') + " Back to #{text}"
    back = link_to(button_text, link, :class => "btn btn-danger")
  end
end
