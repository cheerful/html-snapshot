require 'httpx'
class HTMLSnapshot::SocketClient
  attr_reader :socket_path

  def initialize(path:)
    @socket_path = URI(path).path
  end

  def render(content:, window_size:)
    httpx = HTTPX::Session.new(transport: "unix", transport_options: {path: socket_path})
    httpx.post("http://example.com/", form: {content: content, window_size: window_size})
  end
end