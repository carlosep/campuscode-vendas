require 'active_resource'

class Plan < ActiveResource::Base
  self.site = 'http://localhost:3001/api'
end
