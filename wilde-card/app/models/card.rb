require 'uri'
require 'net/http'
require 'unirest'

class Card < ApplicationRecord
  belongs_to :user

  def self.request_snippets(input)
    url = URI("http://poetrydb.org/lines/#{input}/author,title,lines")
    http = Net::HTTP.new(url.host, url.port)
    request = Net::HTTP::Get.new(url)
    response = http.request(request)
    complete_poems = JSON.parse(response.body)
    parse_snippets(complete_poems, input)
  end

  def self.parse_snippets(complete_poems, user_input)
    storage_array = []
    complete_poems.each do |poem_hash|
      poem_text = poem_hash["lines"].reject(&:blank?)
      poem_text.each_with_index do |line, i|
        if line.include?("#{user_input}") && i === 0
          snippet = poem_text.values_at(i, i + 1, i + 2)
          poem_hash["context"] = snippet
          storage_array << poem_hash
        elsif line.include?("#{user_input}") && i === poem_text.size - 1
          snippet = poem_text.values_at(i - 2, i - 1, i)
          poem_hash["context"] = snippet
          storage_array << poem_hash
        elsif line.include?("#{user_input}")
          snippet = poem_text.values_at(i - 1, i, i + 1)
          poem_hash["context"] = snippet
          storage_array << poem_hash
        end
      end
    end
    return storage_array
  end

end
