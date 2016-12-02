require_relative './emoji_image'
require 'sinatra'
require 'sinatra/reloader'

get '/:text' do
  params[:text]
end


