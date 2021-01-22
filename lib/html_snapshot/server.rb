require_relative 'screenshot_html_content'

require 'sinatra/base'

class HTMLSnapshot::Server < Sinatra::Base
  include HTMLSnapshot::ScreenshotHTMLContent

  attr_reader :headless_browser_path

  def initialize(headless_browser_path:)
    @headless_browser_path = headless_browser_path
    super
  end

  post '/' do
    html_content = params['content']
    window_size = params['window_size']
    content_type "image/gif"
    return render_gif_of_html(html_content, window_size: window_size)
  end
end