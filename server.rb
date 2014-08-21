require 'sinatra'
require 'CSV'
require 'pry'
require "sinatra/reloader"
## site variables ##

site_data = []
CSV_FILE = 'public/site_data.csv'

## site methods ##

def csv_import(filename)
  results = []
  CSV.foreach(filename, headers: true,header_converters: :symbol ) do |row|
    results << row.to_hash
  end
  results
end

## ROUTES ##

get '/' do
  @site_data = csv_import(CSV_FILE)
  erb :index
end

post '/submit' do

  title = params['title']
  url = params['url']
  description = params['description']
  File.open(CSV_FILE, 'a') do |file|
    file.puts "#{title},#{url},#{description}"
  end
  redirect '/'
end


get '/submit' do
  erb :submit
end











