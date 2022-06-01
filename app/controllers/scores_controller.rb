class ScoresController < ApplicationController
    get "/scores" do
        response = Score.joins("inner join users on scores.user_id = users.id").select('users.username, scores.score, users.created_at').order('score DESC').take(20)
        response.to_json
    end

    post '/scores' do
        response = Score.create(score: params[:score], user_id: params[:id])
        response.to_json
      end
end