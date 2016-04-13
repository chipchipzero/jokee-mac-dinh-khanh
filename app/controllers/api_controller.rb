class ApiController < ApplicationController
  rescue_from Exception, :with => :render_500
  layout false

  def render_success(object = nil, message = nil, response_type = 'json')
    hash = { status: 1 }
    hash[:data] = object
    hash[:message] = message unless message.nil?
    if response_type == 'json'
      render json: JSON.pretty_generate(JSON.parse(hash.to_json))
    elsif response_type == 'html'
      render text: JSON.pretty_generate(JSON.parse(hash.to_json))
    end
  end

  def render_failed(reason_number, message, response_type = 'json')
    hash = { status: reason_number, message: message }
    if response_type == 'json'
      render json: JSON.pretty_generate(JSON.parse(hash.to_json))
    elsif response_type == 'html'
      render text: JSON.pretty_generate(JSON.parse(hash.to_json))
    end
  end

  def render_500(exception = nil)
    if exception
      logger.info "Rendering 500 with exception: #{exception.message}"
    end
    #message = exception.message

    #unless Rails.env == 'production'
      message = "#{exception.message}\n#{exception.backtrace.join("\n")}"
    #end

    render_failed(0, message)
  end
end