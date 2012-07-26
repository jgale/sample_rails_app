class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper # they are included in all the views, but not in the controllers
end
