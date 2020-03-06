class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # code actions here!
  get '/recipes/new' do
    erb :new
  end

  post '/recipes' do
    Recipe.new(params.slice("name", "ingredients", "cook_time"))
    redirect "/recipes/#{Recipe.last.id}"
  end

  get '/recipes/:id' do
    @recipe = Recipe.find_by id: params[:id]
    erb :show
  end

  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end

  delete '/recipes/:id' do
    @recipe = Recipe.find_by id: params[:id]
    @recipe.delete
    redirect '/recipes'
  end

  get '/recipes/:id/edit'
    @recipe = Recipe.find_by id: params[:id]
    erb :edit
  end

  patch '/recipes/:id' do
    @recipe = Recipe.find_by id: params[:id]
    @recipe.name = params[:name]
    @recipe.ingredients = params[:ingredients]
    @recipe.cook_time = params[:cook_time]
    @recipe.save
    redirect "/recipes/#{@recipe.id}"
  end
end
