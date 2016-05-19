class Link < ActiveRecord::Base

  validates :website_url, presence: true
  validates :campaign_source, presence: true
  validates :campaign_medium, presence: true
  validates :campaign_name, presence: true
  validates :campaign_source, presence: true

  belongs_to :client
  belongs_to :user

  after_create :make_utm_link

  require 'uri'
  require 'net/http'
  require 'json'

  private

  def make_utm_link
    if /\/\z/.match(self.website_url)
      website_url = self.website_url
    else
      self.website_url = "#{self.website_url}/"
      website_url = self.website_url
    end
    utm_source = "?utm_source=#{self.campaign_source}"
    utm_medium = "&utm_medium=#{self.campaign_medium}"
    if self.communication_id == ""
      utm_term = ""
    else
      utm_term = "&utm_term=#{self.communication_id}"
    end
    if self.utm_content == ""
      utm_content = ""
    elsif self.utm_content
    else
      utm_content = "&utm_content=#{self.utm_content}"
    end
    utm_campaign = "&utm_campaign=#{self.campaign_name}"
    self.utm_link = "#{website_url}#{utm_source}#{utm_medium}#{utm_term}#{utm_content}#{utm_campaign}"
    self.utm_link = URI.escape(self.utm_link)
    self.save
    shorten_with_bitly(self.utm_link)
  end

  def shorten_with_bitly(url)
    unless url[/\Ahttp:\/\//] || url[/\Ahttps:\/\//]
      url = "http://#{url}"
    end
    url = URI.escape(url, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))
    api_key = ENV["BITLY_API_KEY"]
    bitly_url = "https://api-ssl.bitly.com/v3/shorten?access_token=" + api_key + "&longUrl=" + url

    # parse result and return shortened url
    uri = URI.parse(bitly_url)
    result = Net::HTTP.get(uri)
    json = JSON.parse(result)
    short_url = json["data"]["url"]
    self.short_link = short_url
    self.save
  end

end
