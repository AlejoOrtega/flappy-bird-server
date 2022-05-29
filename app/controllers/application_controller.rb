class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'
  
  # GET ROUTES
  get "/" do
    { message: "Welcome to flappy bird sinatra" }.to_json
  end

  get "/users" do
    response = User.all
    response.to_json
  end

  get "/users/:id" do
    response = User.find(params[:id])
    response.to_json
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

end
