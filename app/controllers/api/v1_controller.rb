class Api::V1Controller < ApiController
  # @author: dinhkhanh
  # note : get one joke record by user
  # param: {votes}
  def api1
    user = request.remote_ip
    today = Date.today
    if Vote.where(user: user, voted_on: today).empty?
      if params[:votes].nil? || params[:votes].empty?
        joke = Joke.order('RAND()').first
      else
        # render_success params[:votes] and return
        ids = [];
        params[:votes].each do | vote |
          ids << vote[1][:id]
        end
        joke = Joke.where.not(id: ids).first
      end

      if joke.nil?
        # save vote result
        params[:votes].each do | vote |
          Vote.create!(user: user, joke_id: vote[1][:id], vote: vote[1][:score], voted_on: today)
        end
        render_failed(2, "That's all the jokes for today! Come back another day!")
      else
        render_success joke.as_json({only: [ :id, :content ]})
      end
    else
      render_failed(2, "That's all the jokes for today! Come back another day!")
    end
  end

end
