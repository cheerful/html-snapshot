require 'httparty'
require_relative 'socket_connection_adapter'

class HTMLSnapshot::SocketClient
  include HTTParty

  attr_reader :socket_path

  def initialize(socket_path:)
    @socket_path = socket_path
  end

  self.default_options = {connection_adapter: HTTParty::SocketConnectionAdapter, socket_path: socket_path}

  def render(content:)
    self.class.post('/', body: {content: content}).body
  end
end