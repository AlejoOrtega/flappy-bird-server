class UsersController < ApplicationController

    post "/users/login" do
        if User.exists?(username: params[:username], password: params[:password])
          response = User.where(username: params[:username], password: params[:password])
        else
          response = false
        end
        response.to_json(:only => [ :id, :username ])
    end

    get "/users/:userid/scores" do
        response = User.find(params[:userid]).scores.order("score DESC")
        if response.any?
         response.to_json(:only => [ :user_id, :score, :created_at ])
        else
          response.to_json
        end
    end

    post '/users' do
        if User.exists?(username: params[:username])
          response = false
        else
          response = User.create(username: params[:username], password: params[:password])
        end
        response.to_json(:only => [ :id, :username ])
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