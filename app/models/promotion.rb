require 'active_resource'

class Promotion < ActiveResource::Base
  self.site = "http://localhost:3002/api"
end
