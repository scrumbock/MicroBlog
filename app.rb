require 'sinatra'
require 'sinatra/activerecord'

set :database, 'sqlite3:microdb.sqlite3'
set :sessions, true

require './models'

get '/'  do
  erb :index
end

get '/signup' do
  @users = User.all
  erb :signup
end

post '/signup' do
User.create(username: params[:username], password: params[:password])
  redirect '/signup'
end

get '/signin' do
  erb :signin
end

post '/signin' do
  @user = User.where(username:params[:username]).first
  if @user && @user.password == params[:password]
    session[:user_id] = @user.id
  redirect '/'
else
  redirect '/signin'
end
end
