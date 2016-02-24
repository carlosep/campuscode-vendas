require 'active_resource'
class Product < ActiveResource::Base
  self.site = "http://localhost:3001/api"
end
