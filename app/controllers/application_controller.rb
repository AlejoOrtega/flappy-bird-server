class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'
  
  # GET ROUTES

  get "/scores" do
    response = Score.joins("inner join users on scores.user_id = users.id").select('users.username, scores.score, users.created_at').order('score DESC').take(20)
    response.to_json
  end

  get "/users/:userid/scores" do
    response = User.find(params[:userid]).scores.order("score DESC")
    if response.any?
     response.to_json(:only => [ :user_id, :score, :created_at ])
    else
      response.to_json
    end
  end

  # POST ROUTES
  post "/users/login" do
    if User.exists?(username: params[:username], password: params[:password])
      response = User.where(username: params[:username], password: params[:password])
    else
      response = false
    end
    response.to_json(:only => [ :id, :username ])
  end

  post '/users' do
    if User.exists?(username: params[:username])
      response = false
    else
      response = User.create(username: params[:username], password: params[:password])
    end
    response.to_json(:only => [ :id, :username ])
  end

  post '/score' do
    response = Score.create(score: params[:score], user_id: params[:id])
    response.to_json
  end

  #PATCH ROUTES
  patch '/users/:id' do
    if User.exists?(username: params[:username])
      response = false
    else
      User.find(params[:id]).update(username: params[:username])
    end
    response.to_json(:only => [ :id, :username ])
  end

  #DELETE ROUTES

  delete '/users/:id' do
    response = User.find(params[:id]).destroy
    response.to_json

  end
end
