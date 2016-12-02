require_relative './emoji_image'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/json'
require 'pry'

get '/:text' do
  image = EmojiImage.new params[:text]
  json ({ path: request.base_url + image.path })
end
