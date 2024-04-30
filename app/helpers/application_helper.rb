module ApplicationHelper
  include Pagy::Frontend

  def render_turbo_stream_flash_messages
    turbo_stream.prepend "notifications" do
      flash.map do |_type, data|
        content_tag(:div, data)
      end.join.html_safe
    end
  end
end
