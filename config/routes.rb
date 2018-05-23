Rails.application.routes.draw do
  post 'auth/login', to: 'authentication#authenticate'

  scope :v1, module: :v1, constraints: ApiVersion.new('v1', true) do
    get 'locations/:country_code', to: 'locations#list'
    get 'target_groups/:country_code', to: 'target_groups#list'
    post 'evaluate_target', to: 'targets#evaluate'
  end

  scope 'v1/public', module: 'v1/public', constraints: ApiVersion.new('v1', false) do
    get 'locations/:country_code', to: 'locations#list'
    get 'target_groups/:country_code', to: 'target_groups#list'
  end
end
