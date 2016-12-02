require_relative './emoji_image'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/json'
require 'pry'
require 'securerandom'

get '/:text' do
  image = EmojiImage.new params[:text]
  p image.path
  content_type :png
  send_file image.path
end
