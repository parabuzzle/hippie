module Hippie
  class App < Padrino::Application
    register Padrino::Helpers

    enable :sessions

    ##
    # Caching support.
    #
    # register Padrino::Cache
    # enable :caching
    #
    # You can customize caching store engines:
    #
    # set :cache, Padrino::Cache.new(:LRUHash) # Keeps cached values in memory
    # set :cache, Padrino::Cache.new(:Memcached) # Uses default server at localhost
    # set :cache, Padrino::Cache.new(:Memcached, '127.0.0.1:11211', :exception_retry_limit => 1)
    # set :cache, Padrino::Cache.new(:Memcached, :backend => memcached_or_dalli_instance)
    # set :cache, Padrino::Cache.new(:Redis) # Uses default server at localhost
    # set :cache, Padrino::Cache.new(:Redis, :host => '127.0.0.1', :port => 6379, :db => 0)
    # set :cache, Padrino::Cache.new(:Redis, :backend => redis_instance)
    # set :cache, Padrino::Cache.new(:Mongo) # Uses default server at localhost
    # set :cache, Padrino::Cache.new(:Mongo, :backend => mongo_client_instance)
    # set :cache, Padrino::Cache.new(:File, :dir => Padrino.root('tmp', app_name.to_s, 'cache')) # default choice
    #

    ##
    # Application configuration options.
    #
    # set :raise_errors, true       # Raise exceptions (will stop application) (default for test)
    # set :dump_errors, true        # Exception backtraces are written to STDERR (default for production/development)
    # set :show_exceptions, true    # Shows a stack trace in browser (default for development)
    # set :logging, true            # Logging in STDOUT for development and file for production (default only for development)
    # set :public_folder, 'foo/bar' # Location for static assets (default root/public)
    # set :reload, false            # Reload application files (default in development)
    # set :default_builder, 'foo'   # Set a custom form builder (default 'StandardFormBuilder')
    # set :locale_path, 'bar'       # Set path for I18n translations (default your_apps_root_path/locale)
    # disable :sessions             # Disabled sessions by default (enable if needed)
    # disable :flash                # Disables sinatra-flash (enabled by default if Sinatra::Flash is defined)
    # layout  :my_layout            # Layout can be in views/layouts/foo.ext or views/foo.ext (default :application)
    #

    ##
    # You can configure for a specified environment like:
    #
    #   configure :development do
    #     set :foo, :bar
    #     disable :asset_stamp # no asset timestamping for dev
    #   end
    #

    ##
    # You can manage errors like:
    #
    #   error 404 do
    #     render 'errors/404'
    #   end
    #
    #   error 500 do
    #     render 'errors/500'
    #   end
    #

    disable :raise_errors
    disable :show_exceptions

    get :index do
      body = []
      body << "<html><head><title>Hippie</title></head><body>"
      body << '<br/><br/><br/>'
      body << "<div id='name' style='margin:auto; text-align:center; font-size:48px; color: #333333; font-family:helvetica;'>"
      body << "<b>Microphone Test... 1 2 3</b><br/>"
      body << "</div>"
      body << "<div id='hippie' style='margin:auto; text-align:center; color: #333333; font-family:helvetica;'>"
      body << "<img src='/mic-test.jpg'/>"
      body << "<br/><br/><a href='https://github.com/parabuzzle/hippie'>https://github.com/parabuzzle/hippie</a>"
      body << "</div>"
      body << "</body></html>"
      body.join
    end

    not_found do
      body = []
      body << "<html><head><title>Hippie :: Not Found</title></head><body>"
      body << '<br/><br/><br/>'
      body << "<div id='name' style='margin:auto; text-align:center; font-size:48px; color: #333333; font-family:helvetica;'>"
      body << "<b>Hey maaaaaan.</b><br/>"
      body << "</div>"
      body << "<div id='hippie' style='margin:auto; text-align:center; font-size:38px; color: #333333; font-family:helvetica;'>"
      body << "<img src='/hippie.jpg'/>"
      body << "<br/><br/><b>404 - not found</b>"
      body << "</div>"
      body << "</body></html>"
      body.join
    end

    error do
      body = []
      body << "<html><head><title>Hippie :: Server Error</title></head><body>"
      body << '<br/><br/><br/>'
      body << "<div id='name' style='margin:auto; text-align:center; font-size:48px; color: #333333; font-family:helvetica;'>"
      body << "<b>Oh no! You broke the Bong!</b><br/>"
      body << "</div>"
      body << "<div id='hippie' style='margin:auto; text-align:center; font-size:38px; color: #333333; font-family:helvetica;'>"
      body << "<img src='/fail-hippie.jpg'/>"
      body << "<br/><br/><b>500 - Server Error</b>"
      body << "</div>"
      body << "</body></html>"
      body.join
    end

    def self.protect(protected)
      condition do
        halt 403, "Invalid Application Token" unless params[:auth_token] == Hippie::App.auth_token
      end if protected
    end

    def echo
      p = []
      h = []
      request.body.rewind
      request_payload = request.body.read
      params.each do |k,v|
        p << "#{k}: #{v}"
      end
      headers.each do |k,v|
        h << "#{k}: #{v}"
      end
      logger.info("PARAMS: #{p.join(', ')}")
      logger.info("HEADERS: #{h.join(', ')}")
      logger.info("BODY: #{request_payload}")
      "<b>PARAMS:</b><br/>#{p.join('<br/>')}<br/><br/><b>HEADERS:</b><br/>#{h.join('<br/>')}<br/><br/><b>REQUEST BODY</b><br/>#{request_payload.to_s}"
    end

  end
end
