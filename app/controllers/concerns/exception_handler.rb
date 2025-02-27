module ExceptionHandler
  # provides the more graceful `included` method
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do |e|
      json_response({ message: e.message }, :not_found)
    end    
    
    rescue_from Product::InsufficientStock do |e|
      json_response({ message: 'Insufficient stock available' }, :conflict)
    end
  end
end
