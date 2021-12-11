require 'terrapin'
require 'logger'

module HTMLSnapshot
  module ScreenshotHTMLContent
    def headless_browser_path
      raise NotImplemented
    end

    LOGLEVELS = %w[DEBUG INFO WARN ERROR FATAL UNKNOWN].freeze

    def logger
      if @logger.nil?
        @logger = Logger.new(STDOUT)
        level ||= LOGLEVELS.index ENV.fetch("LOG_LEVEL","WARN") # default to WARN index: 2
        level ||= Logger::WARN  # FIX default in case of environment LOG_LEVEL value is present but not correct
        @logger.level = level
      end

      return @logger
    end

    def render_gif_of_html(html_content, window_size:)
      identifier = "#{rand(987654321)}#{Time.now.to_i}"

      temporary_html_file = create_temporary_html_file(identifier)
      temporary_gif_file = create_temporary_gif_file(identifier)

      temporary_html_file.write(html_content)

      logger.debug(temporary_html_file: temporary_html_file.path, temporary_gif_file: temporary_gif_file.path)

      line = Terrapin::CommandLine.new(
        headless_browser_path,
        "--window-size=:window_size --disable-gpu --headless --hide-scrollbars --screenshot=:screenshot_path :local_html_path",
        logger: logger
      )

      command_options = {
        window_size: window_size,
        screenshot_path: temporary_gif_file.path,
        local_html_path: temporary_html_file.path
      }

      line.run(command_options)

      logger.debug(command_error_output: line.command_error_output, command_output: line.command_output)

      temporary_gif_file.rewind
      gif_content = temporary_gif_file.read

      logger.debug(temporary_html_file_size: temporary_html_file.size, temporary_gif_file_size: temporary_gif_file.size)
      unless ENV["KEEP_HTML_SNAPSHOT_TEMPFILES"]
        temporary_html_file.close
        temporary_html_file.unlink

        temporary_gif_file.close
        temporary_gif_file.unlink
      end

      return gif_content
    end

    protected

    def tempfile_basedir
      if ENV["HTML_SNAPSHOT_TEMPFILES_DIR"]
        return ENV["HTML_SNAPSHOT_TEMPFILES_DIR"]
      else
        return Dir.tmpdir
      end
    end

    def create_temporary_html_file(identifier)
      Tempfile.new([temporary_filename(identifier), '.html'], tempfile_basedir)
    end

    def create_temporary_gif_file(identifier)
      Tempfile.new([temporary_filename(identifier), '.gif'], tempfile_basedir)
    end

    def temporary_filename(identifier)
      "html-snapshot-server-#{identifier}"
    end
  end
end