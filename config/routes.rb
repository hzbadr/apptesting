Rails.application.routes.draw do
  post 'auth/login', to: 'authentication#authenticate'

  scope module: :v1, constraints: ApiVersion.new('v1', true) do
    get 'locations/:country_code', to: 'locations#list'
  end
end
