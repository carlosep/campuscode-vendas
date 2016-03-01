require 'active_resource'

class Promotion < ActiveResource::Base
  self.site = 'http://localhost:3002/api'

  def self.find(*args)
    super(*args)
  rescue ActiveResource::ResourceNotFound
    false
  end
end
