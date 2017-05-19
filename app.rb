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
  redirect '/profile'
else
  redirect '/signin'
end
end

post '/profile' do
Blog.create(title: params[:title], category: params[:category], content: params[:content])
redirect '/profile'
end

get '/profile' do
@blogs = Blog.all
erb :profile
end

post '/logout' do
session[:user_id] = nil
    redirect '/'
end

post '/delete_acct' do
  session[:user_id]
end
