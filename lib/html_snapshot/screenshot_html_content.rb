require 'terrapin'
require 'logger'

module HTMLSnapshot
  module ScreenshotHTMLContent
    def headless_browser_path
      raise NotImplemented
    end

    def logger
      @logger ||= Logger.new(STDOUT)
    end

    def render_gif_of_html(html_content, window_size:)
      identifier = "#{rand(987654321)}#{Time.now.to_i}"

      temporary_html_file = create_temporary_html_file(identifier)
      temporary_gif_file = create_temporary_gif_file(identifier)

      temporary_html_file.write(html_content)

      logger.debug(temporary_html_file: temporary_html_file.path, temporary_gif_file: temporary_gif_file.path)

      line = Terrapin::CommandLine.new(
        headless_browser_path,
        "--window-size=:window_size --disable-gpu --headless --hide-scrollbars --screenshot=:screenshot_path :local_html_path"
      )

      command_options = {
        window_size: window_size,
        screenshot_path: temporary_gif_file.path,
        local_html_path: temporary_html_file.path
      }

      line.run(command_options)

      logger.debug(command: line.command(command_options))

      temporary_gif_file.rewind
      gif_content = temporary_gif_file.read

      temporary_html_file.close
      temporary_html_file.unlink

      temporary_gif_file.close
      temporary_gif_file.unlink

      return gif_content
    end

    protected

    def create_temporary_html_file(identifier)
      Tempfile.new([temporary_filename(identifier), '.html'])
    end

    def create_temporary_gif_file(identifier)
      Tempfile.new([temporary_filename(identifier), '.gif'])
    end

    def temporary_filename(identifier)
      "html-snapshot-server-#{identifier}"
    end
  end
end