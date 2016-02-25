require 'active_resource'

class Coupon < ActiveResource::Base
  self.site = 'http://localhost:3002/api'
end
