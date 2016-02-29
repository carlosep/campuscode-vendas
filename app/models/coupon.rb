require 'active_resource'

class Coupon < ActiveResource::Base
  self.site = 'http://localhost:3002/api'

  def self.find(*args)
    super(*args)
  rescue ActiveResource::ResourceNotFound
    false
  end
end
