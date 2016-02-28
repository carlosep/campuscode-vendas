require 'active_resource'

class Price < ActiveResource::Base
  self.site = 'http://localhost:3001/api'

  def self.find(*args)
    super(*args)
  rescue ActiveResource::ResourceNotFound
    false
  end
end
