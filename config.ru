require 'sinatra'
require 'sinatra/contrib'
require 'sinatra/reloader' if development?
require 'pry'
require_relative './controllers/novel_controller.rb'

use Rack::Reloader
use Rack::MethodOverride

# direct the reuquest to the correct controller
run NovelController
