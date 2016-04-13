Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  namespace :api do
    scope :v1, module: 'v1', as: 'v1' do
      post 'api1'
    end
  end

  scope module: 'front' do
    root "jokee#index"

    get 'tpl' => 'tpl#index'
  end
end
