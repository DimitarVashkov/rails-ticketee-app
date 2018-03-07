require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  it 'handles a missing project correctly' do
    get :show, params: { id: 'not-here' }

    expect(response).to redirect_to(projects_url)
    message = 'The project you were looking for could not be found.'
    expect(flash[:danger]).to eq message
  end
end
