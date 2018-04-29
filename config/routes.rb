Rails.application.routes.draw do
  namespace :api, defaults: {format: :json} do
    scope module: :v1 do
      get '/stats/weekly/', to: 'weekly_stats#show'
      get '/stats/monthly/', to: 'monthly_stats#show'
      post '/trips', to: 'trips#create'
    end
  end
end
