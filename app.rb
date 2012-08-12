require "sinatra"

require File.dirname(File.expand_path(__FILE__)) + "/config/initalizer"

helpers do
end

get "/" do
  @users = User.all
  haml :index
end

get "/:id" do
  @user = User.find(params[:id])
  if @user
    haml :plate
  else
    "User not found"
  end
end

get "/:id/reload" do 
  @user = User.find(params[:id])
  if @user
    @user.clear_plate!
    redirect to("/#{params[:id]}")
  else
    "User not found"
  end
end

not_found do
  "You've been 404-ed"
end
