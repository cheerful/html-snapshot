require_relative 'screenshot_html_content'

include ScreenshotHTMLContent

post '/' do
  html_content = params['content']
  content_type "image/gif"
  return render_gif_of_html(html_content, window_size: "1400,270")
end