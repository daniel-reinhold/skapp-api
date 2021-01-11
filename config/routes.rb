Rails.application.routes.draw do
  resources :participants
  resources :games

  resources :users do
    collection do
      get '/', :action => :index
      post '/create', :action => :create
    end

    member do
      patch '/update', :action => :update
      delete '/delete', :action => :destroy
    end

    resources :sheets do
      collection do
        get '/', :action => :index
        post '/create', :action => :create
      end

      member do
        patch '/update', :action => :update
        delete '/delete', :action => :destroy
      end

      resources :games do
        collection do
          get '/', :action => :index
          post '/create', :action => :create
        end

        member do
          get '/show', :action => :show
          post '/setpoints', :action => :set_points
          delete '/delete', :action => :destroy
        end
      end

      resources :participants do
        collection do
          get '/', :action => :index
          post '/create', :action => :create
        end

        member do
          patch '/update', :action => :update
          delete '/delete', :action => :destroy
        end
      end

    end
  end
end
