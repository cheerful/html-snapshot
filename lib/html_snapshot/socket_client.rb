require 'httparty'
require_relative 'socket_client/socket_connection_adapter'

class HTMLSnapshot::SocketClient
  include HTTParty

  def initialize(socket_path:)
    options[:socket_path] = socket_path
  end

  self.default_options = {connection_adapter: HTTParty::SocketConnectionAdapter}

  def render(content:)
    self.class.post('/', body: {content: content}).body
  end
end