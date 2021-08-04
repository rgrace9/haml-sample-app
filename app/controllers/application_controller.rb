class ApplicationController < ActionController::Base
    # include ApplicationHelper
    def hello
        render html: "hello, world!"
    end
end
