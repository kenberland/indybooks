#!/usr/bin/env ruby

require 'bundler'
Bundler.require

dotpath = File.expand_path(File.dirname(__FILE__))
$LOAD_PATH.unshift(dotpath) unless $LOAD_PATH.include?(dotpath)
require 'dynamodb_manager'

## Constants
VENDOR_UUID = SecureRandom.uuid

raise 'you must set INDY_ENV' if ENV['INDY_ENV'].nil?

class Xml2DDB

  def initialize
    @isbn_list = []
  end

  def import_xml(input_file)
    doc = File.open(input_file) { |f| Nokogiri::Slop(f) }
    books = doc.xpath("//book")
    books.each do |book|
      @isbn_list.push(
        {
          isbn: book.isbn.text,
          title: book.mainsection.title.text
        }
      )
    end
    return @isbn_list
  end

end

xmlddb = Xml2DDB.new
books = xmlddb.import_xml('book_2020-08-27_17-12-22-export.xml')

raise "Oh gosh I can't talk to the db" if ENV['AWS_ACCESS_KEY_ID'].nil? ||
                                          ENV['AWS_SECRET_ACCESS_KEY'].nil? ||
                                          ENV['AWS_ACCESS_KEY_ID'].empty? ||
                                          ENV['AWS_SECRET_ACCESS_KEY'].empty?

options = {
  region: ENV['AWS_REGION'],
  table_name: "indybooks_inventory_#{ENV['INDY_ENV']}"
}

if ENV['INDY_ENV'] != 'production'
  options[:endpoint] = 'http://localhost:8000'
end

manager = DynamodbManager.new(options)

manager.table # side-effect is to create my table



vendor_uuids = %w/4daced65-0bd0-569f-8376-be542d5ab23b 7b42214a-021a-59ea-a4c7-9f3e049bfabc
 6df48734-55c0-5f03-9f84-d28aad46b5c7 5fa6f746-27b6-55b6-9c7d-193fdee21468 fad13e49-7231-52b6-b343-37ce2a5911de/

offset = Integer(rand *vendor_uuids.size)
books.each_with_index do |book, idx|
  offer = {
    isbn:  book[:isbn],
    vendor_uuid: vendor_uuids[ (idx + offset) % vendor_uuids.size],
    delivery_promise: (rand > 0.5 ? '24hHD' : '1hPU'),
    ask: (Integer(rand*1000)+500)/100.0 # $5 - $15.00
  }
  puts vendor_uuids[ (idx+offset) % vendor_uuids.size]
  manager.put_offer(offer)
end

puts manager.query('9780520081987')

