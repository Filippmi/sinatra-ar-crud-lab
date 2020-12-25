
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
  end

  get '/articles' do
    @articles = Article.all
    erb :'articles/index'
  end

  get '/articles/new' do
    erb :'articles/new'
  end

  post '/articles' do
    article = Article.create(params[:article])

    redirect "/articles/#{article.id}"
  end

  get "/articles/:id/edit" do
    find_article
    erb :'articles/edit'
  end
  
  get "/articles/:id" do
    find_article
    erb :'articles/show'
  end
  
  patch "/articles/:id" do
    find_article
    article = Article.update(params[:article])
    redirect "/articles/#{article.id}"
  end

  delete "/article/:id" do  
    find_article
    @article.destroy
    redirect "/articles"
  end

  def find_article
    @article = Article.find_by_id(params[:id])
  end
end
