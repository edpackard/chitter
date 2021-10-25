require 'sinatra/base'
require 'sinatra/reloader'

class Chitter < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get '/peeps' do
    @peeps = [
      'This is a test peep!',
      'This is another test peep!',
      'Yet another test peep.'
    ]
    erb :'peeps/index'
  end

  run! if app_file == $0
end
