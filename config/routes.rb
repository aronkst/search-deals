Rails.application.routes.draw do
  root 'home#index'

  post 'sales/:scraper_id', to: 'sale_groups#create', as: 'sale_groups_create'
  get 'sales/:scraper_id/:sale_group_id', to: 'sale_groups#show', as: 'sale_groups_show'
  delete 'sales/:scraper_id/:sale_group_id', to: 'sale_groups#destroy', as: 'sale_groups_destroy'

  resources :scrapers
  post 'scrapers/:id/clone', to: 'scrapers#clone', as: 'sale_groups_clone'
  scope 'scrapers/:scraper_id/:value' do
    resources :scraper_attributes, except: [:index]
  end
end
