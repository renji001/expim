Rails.application.routes.draw do

  root 'patchs#index'
  post 'patchs/load_excel' => 'patchs#load_excel'
  get 'patchs/yx_print' => 'patchs#yx_print'
  get 'patchs/bs_print' => 'patchs#bs_print'
  get 'patchs/ciq_c_print' => 'patchs#ciq_c_print'
  get 'patchs/ciq_in_print' => 'patchs#ciq_in_print'
  get 'patchs/get_real_waybill' => 'patchs#get_real_waybill'
  get 'patchs/ciq_in_excel' => 'patchs#ciq_in_excel'
  get 'patchs/syn_pic' => 'patchs#syn_pic'
  get 'patchs/ciq_release' => 'patchs#ciq_release'
  get 'patchs/print_id' => 'patchs#print_id'
  get 'patchs/print_inv' => 'patchs#print_inv'

  post 'patchs/img_upload' => 'patchs#img_upload'
  post 'patchs/invoice_img_upload' => 'patchs#invoice_img_upload'

  devise_for :users, skip: :passwords do
  	get 'users/sign_in' => 'devise/sessions#new', :as => 'user_signin'
  	post 'signin' => 'devise/sessions#create', :as => :user_signed
  	get 'signin' => 'devise/sessions#new'
  	get 'signout' => 'devise/sessions#destroy'
  	get 'signup' => 'devise/registrations#new'
  end

end
