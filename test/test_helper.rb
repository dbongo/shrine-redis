require "bundler/setup"

require "minitest/autorun"
require "minitest/spec"

require "shrine/storage/redis_storage"

require "forwardable"
require "stringio"

class FakeIO
  def initialize(content)
    @io = StringIO.new(content)
  end

  extend Forwardable
  delegate [:read, :size, :close, :eof?, :rewind] => :@io
end

class Minitest::Test
  def fakeio(content = File.binread("test/fixtures/fuck_tornados.jpg"))
    FakeIO.new(content)
  end
end
