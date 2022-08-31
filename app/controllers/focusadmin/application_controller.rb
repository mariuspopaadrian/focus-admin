module Focusadmin
  class ApplicationController < ::ApplicationController
  	before_action :authenticate_admin!
  	#layout "application"
  end
end
