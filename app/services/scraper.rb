require 'httparty' 
require 'nokogiri'
require 'byebug'
require_relative 'base_scraper'

# Draft version
# TODO: 
#     * Refactor
#     * Extract shared logic to BaseScraper
#     * Validate if link is supported
class Scraper
  attr_accessor :parsed_data

  def initialize(link)
    @parsed_data = scrape_data(link)
  end

  private

  def scrape_data(link)
    html = HTTParty.get(link)
    response ||= Nokogiri::HTML(html.body)

    price = response.css('.re-DetailHeader-price').text.delete('^0-9').to_i
    phone = response.css('.re-ContactDetail-phone').first.text.delete(' ')
    rooms = response.css('ul.re-DetailHeader-features').children.first.text.delete('^0-9').to_i
    bathrooms = response.css('ul.re-DetailHeader-features').children[1].text.delete('^0-9').to_i
    size = response.css('ul.re-DetailHeader-features').children[2].text.delete('^0-9').to_i
    floor = response.css('ul.re-DetailHeader-features').children.last.text.delete('^0-9').to_i
    owner_name = response.css('.re-ContactDetail-inmoLogo').first.attributes["alt"].value
    owner_category =  set_owner_category(owner_name)
    category = set_house_category(link)

    return format_data(price, phone, rooms, bathrooms, size, link, category, owner_name, owner_category)
  end

  def format_data(price, phone, rooms, bathrooms, size, link, category, owner_name, owner_category)
    {
      house_params: {
        price: price,
        rooms: rooms,
        size: size,
        link: link,
        bathrooms: bathrooms,
        category: category
      },
      owner_params: {
        phone: phone,
        name: owner_name,
        category: owner_category
      }
    }
  end

  def set_house_category(link)
    return :sale if link.include?("comprar")
    return :rent if link.include?("alquiler")
  end

  def set_owner_category(owner_name)
    return :real_state if owner_name.include?("Inmuebles")
  end
end

