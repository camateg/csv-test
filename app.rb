require 'sinatra'
require 'csv'

get '/' do
  haml :upload
end

post '/upload' do
  unless params[:file] &&
    (tmpfile = params[:file][:tempfile]) &&
    (name = params[:file][:filename])
    @error = "No file selected"
    return haml :upload
  end  
  STDERR.puts "Uploading file, original name #{name.inspect}"
  rows = Array.new 
  CSV.foreach(tmpfile) do |row|
    rows.push row
  end
 
  haml :output, :locals => {:rows => rows}
end
