Rails.application.routes.draw do
  namespace :api, defaults: {format: :json} do
    scope module: :v1 do
      get '/stats/weekly/', to: 'trips#weekly_stats'
      get '/stats/monthly/', to: 'trips#monthly_stats'
      post '/trips', to: 'trips#create'
    end
  end
end
