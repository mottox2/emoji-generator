require_relative './generator'
require 'sinatra'
require 'sinatra/reloader'

get '/:text' do
  params[:text]
end


