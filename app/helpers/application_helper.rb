module ApplicationHelper
  # Hotrails.dev and https://github.com/hotwired/turbo-rails/pull/296/files
  def nested_dom_id(*args)
    args.map { |arg| arg.respond_to?(:to_key) ? dom_id(arg) : arg }.join("_")
  end

  # https://stackoverflow.com/questions/22787021/rails-4-name-of-current-layout
  def current_layout
    controller_layout = controller.send :_layout, lookup_context, [:html]
    if controller_layout.is_a? ActionView::Template
      controller_layout.short_identifier.split("/").last.gsub(/.html.erb/, "")
    else # it's a String
      controller_layout
    end
  end
end
