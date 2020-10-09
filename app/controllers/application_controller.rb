class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # code actions here!

  get '/recipes' do
    @recipes = Recipe.all

    erb :index
  end

  get '/recipes/new' do
    erb :new
  end

  post '/recipes' do
    @recipe = Recipe.create(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])
    
    
    redirect to "/recipes/#{@recipe.id}"
  end

  get '/recipes/:id' do |id|
    @recipe = Recipe.find(id)

    erb :show
  end

  get '/recipes/:id/edit' do |id|
    @recipe = Recipe.find(id)

    erb :edit
  end
 
  patch '/recipes/:id' do |id|
    @recipe = Recipe.find(id)
    @recipe.name = params[:name]
    @recipe.ingredients = params[:ingredients]
    @recipe.cook_time = params[:cook_time]
    @recipe.save


    redirect "/recipes/#{id}"
  end

  delete '/recipes/:id' do |id|
    @recipe = Recipe.find(id)
    @recipe.delete

    redirect to '/recipes'
  end
end
