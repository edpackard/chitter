require 'sinatra/base'
require 'sinatra/flash'
require 'sinatra/reloader'

require_relative './lib/peep'
require_relative './lib/user'
require_relative './database_connection_setup'

class Chitter < Sinatra::Base
  enable :sessions
  register Sinatra::Flash
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    redirect '/peeps'
  end

  get '/peeps' do
    @user = User.find(session[:user_id])
    @peeps = Peep.all
    erb :'peeps/index'
  end

  post '/peeps' do
    redirect '/peeps' if Peep.create(content: params[:content], user_id: session[:user_id])
    flash[:notice] = 'Peeps must be between 1-140 characters.'
    redirect '/peeps/new' 
  end

  get '/peeps/new' do
    redirect '/peeps' unless session[:user_id]
    erb :'peeps/new'
  end

  post '/users' do
    user = User.create(name: params[:name], email: params[:email], password: params[:password])
    redirect '/users/new' unless user
    session[:user_id] = user.id
    redirect '/peeps'
  end

  get '/users/new' do
    redirect '/peeps' if session[:user_id]
    erb :'users/new'
  end

  run! if app_file == $0
end
