require "test_helper"
require "shrine/storage/linter"
require "redis"

REDIS = Redis.new

describe Shrine::Storage::RedisStorage do
  def redis(options = {})
    options[:prefix] = 'store'
    options[:expire] = 60
    Shrine::Storage::RedisStorage.new(REDIS, options)
  end

  before do
    @redis = redis
  end

  after do
    @redis.clear!
  end

  it "passes the linter" do
    Shrine::Storage::Linter.new(@redis).call
  end

  describe "#upload" do
    it "uploads file to Redis storage" do
      @redis.upload(fakeio, "fuck_tornados.jpg")

      assert_equal true, REDIS.exists("store:fuck_tornados.jpg")
    end
  end

  describe "#exists?" do
    it "checks for file in Redis storage" do
      @redis.upload(fakeio, "fuck_tornados.jpg")

      assert_equal REDIS.exists("store:fuck_tornados.jpg"), @redis.exists?("fuck_tornados.jpg")
    end
  end

  describe "#open" do
    it "opens file from Redis storage" do
      @redis.upload(fakeio, "fuck_tornados.jpg")
      img = @redis.open("fuck_tornados.jpg")

      assert_equal fakeio.size, img.size
    end
  end

  describe "#delete" do
    it "deletes file from Redis storage" do
      @redis.upload(fakeio, "fuck_tornados.jpg")
      @redis.delete("fuck_tornados.jpg")

      assert_equal false, @redis.exists?("fuck_tornados.jpg")
    end
  end
end
