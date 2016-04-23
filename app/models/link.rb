class Link < ActiveRecord::Base

  validates :website_url, presence: true
  validates :campaign_source, presence: true
  validates :campaign_medium, presence: true
  validates :campaign_name, presence: true
  validates :campaign_source, presence: true


  belongs_to :client
end
