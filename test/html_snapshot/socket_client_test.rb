require "test_helper"

class HTMLSnapshot::SocketClientTest < Minitest::Test
  class TestClass < HTMLSnapshot::SocketClient
    socket_path "unix:///tmp/socket-test.sock"
  end

  def test_setting_up_options_in_subclass
    socket_path = "unix:///tmp/socket-test.sock"

    assert_equal ({connection_adapter: HTTParty::SocketConnectionAdapter, socket_path: socket_path}), TestClass.default_options
  end
end
