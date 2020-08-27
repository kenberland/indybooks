#!/usr/bin/env ruby

require 'bundler'
Bundler.require

## Constants
FOO = 'bar'

class Xml2DDB

  def initialize
  end

  def import_xml(input_file)
    doc = File.open(input_file) { |f| Nokogiri::Slop(f) }
    books = doc.xpath("//book")
    books.each do |book|
      puts "#{book.isbn.text}\t#{book.mainsection.title.text}"
    end
  end

end

# binding.pry; 1
xmlddb = Xml2DDB.new
xmlddb.import_xml('book_2020-08-27_17-12-22-export.xml')
