# Run `gem install sinatra` to install the sinatra gem in your computer
# To starter your server, run `ruby server.rb`
# In your browser, go to `localhost:4567`

require 'sinatra'
require 'byebug'
require 'net/http'
require 'json'

BASE_URI = 'https://api.spotify.com'

get '/' do
  if params['name'] && !params['name'].empty?
    @artists = artist_search(params['name'])
  end

  erb :index
end

get '/artists/' do
  if params['id']
    @artist = artist(params['id'])
    @related_artists = related_artists(params['id'])
    @artist_image_url = image_url
  end

  erb :show
end

private

def artist_search(name)
  uri = URI("#{BASE_URI}/v1/search?q=#{name}&type=artist")
  JSON.parse(Net::HTTP.get(uri))['artists']['items']
end

def artist(id)
  uri = URI("#{BASE_URI}/v1/artists/#{id}")
  JSON.parse(Net::HTTP.get(uri))
end

def related_artists(id)
  uri = URI("#{BASE_URI}/v1/artists/#{id}/related-artists")
  JSON.parse(Net::HTTP.get(uri))['artists']
end

def image_url
  if @artist['images'].any?
    @artist['images'].first['url']
  else
    "http://i.dailymail.co.uk/i/pix/2016/05/11/10/34091E0A00000578-3584384-image-a-8_1462957988141.jpg"
  end
end