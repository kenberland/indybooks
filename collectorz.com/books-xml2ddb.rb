#!/usr/bin/env ruby

require 'bundler'
Bundler.require

dotpath = File.expand_path(File.dirname(__FILE__))
$LOAD_PATH.unshift(dotpath) unless $LOAD_PATH.include?(dotpath)
require 'dynamodb_manager'

## Constants
VENDOR_UUID = SecureRandom.uuid

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

books.each do |book|
  offer = {
    isbn:  book[:isbn],
    vendor_uuid: SecureRandom.uuid,
    delivery_promise: (rand > 0.5 ? '24-hour-home-delivery' : 'curbside-pickup'),
    ask: (Integer(rand*1000)+500)/100.0 # $5 - $15.00
  }
  manager.put_offer(offer)
end

puts manager.query('9780520081987')

