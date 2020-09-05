#!/usr/bin/env ruby

require 'bundler'
Bundler.require

require 'pry'
require 'csv'
require "active_support/core_ext/digest/uuid"
CSV_FILE = 'indybooks-stores.v01.csv'

dotpath = File.expand_path(File.dirname(__FILE__))
$LOAD_PATH.unshift(dotpath) unless $LOAD_PATH.include?(dotpath)

raise "Oh gosh I can't talk to the db" if ENV['AWS_ACCESS_KEY_ID'].nil? ||
                                          ENV['AWS_SECRET_ACCESS_KEY'].nil? ||
                                          ENV['AWS_ACCESS_KEY_ID'].empty? ||
                                          ENV['AWS_SECRET_ACCESS_KEY'].empty?

options = {
  region: ENV['AWS_REGION'],
  table_name: "indybooks_stores_#{ENV['INDY_ENV']}"
}

if ENV['INDY_ENV'] != 'production'
  options[:endpoint] = 'http://localhost:8000'
end

manager = DynamodbManager.new(**options)

manager.table # side-effect is to create my table

CSV.foreach(CSV_FILE, headers: true) do |row|
  store_h = row.to_hash.transform_keys(&:to_sym)
  store_h[:area_code] = store_h[:area_code].to_i
  store_h[:phone] = store_h[:phone].to_i
  store_h[:zip] = store_h[:zip].to_i
  store_h[:longitude] = store_h[:longitude].to_f
  store_h[:latitude] = store_h[:latitude].to_f
  store_h[:name].downcase.gsub(/\W/,'') # canonicalize the name
  store_h[:uuid] = Digest::UUID.uuid_v5(store_h[:name].downcase, "#{store_h[:lat].to_s}#{store_h[:long].to_s}")
  store = Store.new(store_h)
  geohash = manager.put_store(store)
  puts "new store #{store.name}, uuid #{store.uuid}" if geohash
end
