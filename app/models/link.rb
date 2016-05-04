class Link < ActiveRecord::Base

  validates :website_url, presence: true
  validates :campaign_source, presence: true
  validates :campaign_medium, presence: true
  validates :campaign_name, presence: true
  validates :campaign_source, presence: true

  belongs_to :client

  after_create :make_utm_link

  require 'uri'

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
  end

end
