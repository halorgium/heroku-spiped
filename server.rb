#!/usr/bin/env ruby

require 'ffi-rzmq'

p context = ZMQ::Context.new
p socket = context.socket(ZMQ::PULL)
p socket.bind(ENV.fetch("ZMQ_BIND_URI"))
loop do
  s = []
  p socket.recv_strings(s)
  puts "strings: #{s.inspect}"
end
