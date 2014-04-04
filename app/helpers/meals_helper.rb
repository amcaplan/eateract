module MealsHelper
  def tab_dd(text, href, active = false, add_class = nil)
    content_tag :dd, content_tag(:a, text, href: href),
      class: "#{("active" if active)} #{add_class}"
  end

  def content_div(id, partial_name, extra_class = nil, f)
    content_tag :div, (render partial: partial_name, locals: {f: f}),
      class: "content #{extra_class}", id: id
  end

  def person_field(text = nil, &block)
    content_tag(:div, raw(text), class: "medium-4 small-12 columns", &block)
  end
end
