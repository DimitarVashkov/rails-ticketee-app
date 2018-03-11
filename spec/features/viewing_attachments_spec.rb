require "rails_helper"
RSpec.feature "Users can view a ticket's attached files" do
  let(:user) { create :user }
  let(:project) { create :project }
  let(:ticket) { create :ticket, project: project, author: user }
  let!(:attachment) { create :attachment, ticket: ticket,
                             file_to_attach: "spec/fixtures/speed.txt" }
  before do
    assign_role!(user, :viewer, project)
    login_as(user)
  end
  scenario "successfully" do
    visit project_ticket_path(project, ticket)
    click_link "speed.txt"
    expect(current_path).to eq attachment_path(attachment)
    expect(page).to have_content "The blink tag can blink faster"
  end
end