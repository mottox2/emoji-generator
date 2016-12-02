require_relative './emoji_image'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/json'

get '/:text' do
  image = EmojiImage.new params[:text]
  json ({ path: image.path })
end
