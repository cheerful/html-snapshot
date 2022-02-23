require "test_helper"

class HTMLSnapshot::SocketClientTest < Minitest::Test
  class TestClass < HTMLSnapshot::SocketClient
  end

  def test_setting_up_path_in_subclass
    socket_path = "unix:///tmp/socket-test.sock"

    instance = TestClass.new(path: socket_path)
    assert_equal "/tmp/socket-test.sock", instance.socket_path
  end
end
