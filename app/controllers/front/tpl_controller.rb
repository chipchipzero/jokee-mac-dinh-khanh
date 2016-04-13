class Front::TplController < FrontController
  rescue_from Exception, :with => :render_500

  layout false

  def index
    render file: "front#{params[:path]}"
  end

  def render_500(exception = nil)
    if exception
      puts exception.message
      if Rails.env == 'development'
        render text: exception.message
      else
        render text: "Template with path #{params[:path]} is not exist."
      end

    end
  end

end
