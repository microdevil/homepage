Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	resources :reservations, only:[] do
		collection do
	    	post  :submit
	    end
	end
end
