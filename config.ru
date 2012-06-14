Thread.abort_on_exception = true

require 'sinatra/base'

class App < Sinatra::Base
  before do
    content_type :text
  end

  get '/' do
    "Hello world"
  end

  get '/lsof' do
    `lsof -nP`
  end

  get '/raw' do
    p system("ruby client.rb raw")
    "via raw"
  end

  get '/spiped' do
    p system("env ZMQ_CONNECT_URI=ipc://#{ENV.fetch("SPIPED_CLIENT_SOURCE_SOCKET")} ruby client.rb spiped")
    "via spiped"
  end

  get '/thread' do
    "thread: #{$thread.inspect}"
  end
end

$thread = Thread.new do
  pid = Process.spawn("./start-spiped-client >&2")
  $stderr.puts "spiped started on pid #{pid.inspect}"
  p system("lsof -nPp #{pid} >&2")
  _, status = Process.wait2(pid)
  $stderr.puts "spiped exited with #{status.inspect}"
  exit(1)
end

run App
