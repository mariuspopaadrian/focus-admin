module Focusadmin
  module ApplicationHelper

    def curator_page_path(username)
      if username.present?
      escaped_username = URI.escape(username)
      return main_app.root_path + "c/" + escaped_username
      else
        return main_app.root_path
      end
    end

  end
end
