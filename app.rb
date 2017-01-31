%w(sinatra).each  { |lib| require lib}
require 'awesome_print'
require 'digest/md5'
require 'cgi'


disable :show_exceptions
enable :inline_templates # , :logging, :dump_errors, :raise_errors
helpers do

  def protected!
    unless authorized?
      response['WWW-Authenticate'] = %(Basic realm="Facebook login expired, You need to login to facebook again")
      throw(:halt, [401, "Not authorized\n"])
    end
  end

  def authorized?
    @auth ||=  Rack::Auth::Basic::Request.new(request.env)
    @auth.provided? && @auth.basic? && @auth.credentials && valid_credentials?(@auth.credentials)
  end

  def valid_credentials?(credentials)
      return true if credentials == ['hola', 'admin@321']
      return false
  end
  

end

get '/' do 
    protected!
    "Hello World"
end

get '/hi' do
    "Hello World"
end


get '/search' do
    "Hello  " + params[:term]
end
