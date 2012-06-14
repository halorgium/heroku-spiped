require 'ffi-rzmq'

p context = ZMQ::Context.new
p socket = context.socket(ZMQ::PUSH)
p socket.connect(ENV.fetch("ZMQ_CONNECT_URI"))
p socket.send_strings(["hello", *ARGV])
