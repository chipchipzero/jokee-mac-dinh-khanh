class Api::V1Controller < ApiController
  # @author: dinhkhanh
  # note : get one joke record by user
  # param: {ids}
  def api1
    user = request.remote_ip
    if Vote.where(user: user, voted_on: Date.today).empty?
      if params[:ids].nil?
        joke = Joke.order('RAND()').first
      else
        joke = Joke.where.not(id: params[:ids]).first
      end

      render_success joke.as_json({only: [ :id, :content ]})
    else
      render_failed(2, "That's all the jokes for today! Come back another day!")
    end
  end
end
