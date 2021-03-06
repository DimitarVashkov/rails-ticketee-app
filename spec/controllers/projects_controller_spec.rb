require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  it 'handles a missing project correctly' do
    get :show, params: { id: 'not-here' }

    expect(response).to redirect_to(projects_url)
    message = 'The project you were looking for could not be found.'
    expect(flash[:danger]).to eq message
  end
  it "handles permission errors by redirecting to a safe place" do
    allow(controller).to receive(:current_user)
    project = create(:project)
    get :show, params: { id: project }
    expect(response).to redirect_to(root_path)
    message = "You are not allowed to do that."
    expect(flash[:danger]).to eq message
  end
end
