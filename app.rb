require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'slim'
require './models/quote'


get '/' do
  @quote = Quote.random_quote
  slim :index
end
  