class App < Sinatra::Base
  enable :sessions
  use Rack::Flash

  before do
    if session.has_key?(:user_id)
      @user = User.get(session[:user_id])
      unless @user
        halt 401, "Unauthorized"
      end
    end
  end

  get '/' do
    redirect "/user" if @user
  	erb :startsida
  end

  get '/user' do
    redirect "/" unless @user

    erb :user
  end

  get '/create_task' do
    erb :create_task
  end

  post '/login' do
    username = params[:username]
    password = params[:password]

    user = User.first(username: username)
    unless user
      halt 401, "Unauthorized"
    end

    unless user.password == password
      halt 403, "Forbidden"
    end

    session[:user_id] = user.id
    redirect "/user"
  end

  get '/logout' do
    session.destroy
    redirect "/"
  end

  get '/register' do
    erb :register
  end


  post '/register' do
    first_name = params[:first_name]
    last_name = params[:last_name]
    mail = params[:mail]
    username = params[:username]
    password = params[:password]

    user = User.create(first_name: first_name,
                       last_name: last_name,
                       mail: mail,
                       username: username,
                       password: password)

    if user.valid?
      redirect '/user'
    else
      flash[:error] = user.errors.to_h
      redirect back
    end
  end

  post '/create_task' do
    title = params[:title]
    description = params[:description]

    task = Task.create(title: title,
                       description: description,
                       user_id: session[:user_id])
    if task.valid?
      redirect '/user'
    else
      flash[:error] = task.errors.to_h
      redirect '/create_task'
    end
  end
end
