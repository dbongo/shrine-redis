require "test_helper"
require "shrine/storage/linter"
require "redis"

REDIS = Redis.new

describe Shrine::Storage::Redis do
  def redis(options = {})
    options[:client] = REDIS
    options[:prefix] = "store"
    Shrine::Storage::Redis.new(options)
  end

  before do
    @redis = redis
  end

  after do
    REDIS.flushdb
  end

  it "passes the linter" do
    Shrine::Storage::Linter.new(@redis).call
  end

  describe "#upload" do
    it "uploads file to redis storage" do
      assert_equal false, REDIS.exists("store:123456789:fake.jpg")

      @redis.upload(fakeio, "123456789:fake.jpg")

      assert_equal true, REDIS.exists("store:123456789:fake.jpg")
    end
  end

  describe "#exists?" do
    it "checks for file in redis storage" do
      @redis.upload(fakeio, "123456789:fake.jpg")

      assert_equal true, @redis.exists?("123456789:fake.jpg")
    end
  end

  describe "#open" do
    it "opens file from redis storage" do
      @redis.upload(fakeio, "123456789:fake.jpg")

      img = @redis.open("123456789:fake.jpg")

      assert_equal fakeio.size, img.size
    end
  end

  describe "#delete" do
    it "deletes single file from redis storage" do
      @redis.upload(fakeio, "123456789:fake.jpg")

      assert_equal true, @redis.exists?("123456789:fake.jpg")

      @redis.delete("123456789:fake.jpg")

      assert_equal false, @redis.exists?("123456789:fake.jpg")
    end
  end

  describe "#multi_delete" do
    it "deletes multiple files from redis storage" do
      @redis.upload(fakeio, "123456789:fake.jpg")
      @redis.upload(fakeio, "123456789:fake_32x32.jpg")
      @redis.upload(fakeio, "123456789:fake_64x64.png")
      @redis.upload(fakeio, "123456789:real.jpg")

      @redis.multi_delete("123456789:fake")

      assert_equal false, @redis.exists?("123456789:fake.jpg")
      assert_equal false, @redis.exists?("123456789:fake_32x32.jpg")
      assert_equal false, @redis.exists?("123456789:fake_64x64.png")
      assert_equal true, @redis.exists?("123456789:real.jpg")
    end
  end
end
