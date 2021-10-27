require 'sinatra/base'
require 'sinatra/reloader'

require './lib/peep'

class Chitter < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get '/peeps' do
    @peeps = Peep.all
    erb :'peeps/index'
  end

  post '/peeps' do
    Peep.create(content: params[:content])
    redirect '/peeps'
  end

  get '/peeps/new' do
    erb :'peeps/new'
  end

  run! if app_file == $0
end
