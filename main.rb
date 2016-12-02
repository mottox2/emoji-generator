require_relative './generator'
require 'sinatra'

get '/:text' do
  params[:text]
end


