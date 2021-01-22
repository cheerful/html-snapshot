#Adapted from: https://stackoverflow.com/a/20266691
require_relative 'socket_http'
require "httparty"

class HTTParty::SocketConnectionAdapter < HTTParty::ConnectionAdapter
  #  Override the base class connection method.
  #  Only difference is that we'll create a Net::SocketHttp rather than a Net::HTTP.
  #  Relies on :socket_path in the
  def connection
    http = Net::SocketHttp.new(uri, options[:socket_path])

    if options[:timeout] && (options[:timeout].is_a?(Integer) || options[:timeout].is_a?(Float))
      http.open_timeout = options[:timeout]
      http.read_timeout = options[:timeout]
    end

    if options[:debug_output]
      http.set_debug_output(options[:debug_output])
    end

    if options[:ciphers]
      http.ciphers = options[:ciphers]
    end

    return http
  end
end
