require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'dotenv/load'
require 'slim'
require './models/quote'
require './services/service'
require './services/quote/get_from_google_docs'

get '/' do
  @quote = Quote.random_quote
  slim :index
end

get '/update' do
  slim :update
end

post '/update/' do
  if params[:pass] == ENV["UPDATE_PASS"]
    Quote::GetFromGoogleDocs.call
    redirect '/'
  end
  redirect '/update'
end
