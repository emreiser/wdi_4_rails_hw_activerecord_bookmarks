Bookmarker::Application.routes.draw do
  devise_for :users
 resources :bookmarks
 root to: 'bookmarks#index'
end
