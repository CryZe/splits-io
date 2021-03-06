require 'net/http'

class Twitch
  module User
    private

    def self.find(name)
      Twitch.kraken["/users/#{name}"]
    end
  end

  module Follows
    def self.find_by_user(user)
      Rails.cache.fetch([:twitch, :follows, user]) do
        JSON.parse(
          Twitch::User.find(user.name)["/follows/channels?oauth_token=#{user.twitch_token}&limit=500"].get
        )['follows'].map do |follow|
          follow['channel']['_id']
        end
      end
    end
  end

  private

  def self.kraken
    RestClient::Resource.new('https://api.twitch.tv/kraken')
  end
end
