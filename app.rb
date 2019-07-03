require 'rubygems'
require 'sinatra/base'
require 'dotenv/load'
require 'slim'
require "bundler/setup"
require './models/quote'
require './services/service'
require './services/quote/get_from_google_docs'

class GaginQuote < Sinatra::Base
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
end
