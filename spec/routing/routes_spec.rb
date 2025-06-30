require 'rails_helper'

RSpec.describe 'Routes', type: :routing do
  it 'routes /login to sessions#new' do
    expect(get: '/login').to route_to('sessions#new')
  end

  it 'routes /logout to sessions#destroy' do
    expect(delete: '/logout').to route_to('sessions#destroy')
  end

  it 'routes /signup to registrations#new' do
    expect(get: '/signup').to route_to('registrations#new')
  end

  it 'routes short code' do
    expect(get: '/abc123').to route_to('redirect#show', short_code: 'abc123')
  end

  it 'does not route an unknown path' do
    expect(get: '/unknown123').not_to be_routable
  end
end
