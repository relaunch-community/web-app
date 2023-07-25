module ApplicationHelper
  # Hotrails.dev and https://github.com/hotwired/turbo-rails/pull/296/files
  def nested_dom_id(*args)
    args.map { |arg| arg.respond_to?(:to_key) ? dom_id(arg) : arg }.join("_")
  end
end
