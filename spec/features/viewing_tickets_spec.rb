require 'rails_helper'

RSpec.feature 'User can view tickets' do
  before do
    author = create(:user)
    sublime = create(:project, name: 'Sublime Text 3')
    create(:ticket, project: sublime, name: 'Make it shiny!', description: 'Gradients!',author:author)

    ie = create(:project, name: 'Internet Explorer')
    create(:ticket, project: ie, name: 'Standards comp', description: 'Isnt a joke',author: author)

    visit '/'
  end

  scenario 'for a given project' do
    click_link 'Sublime Text 3'
    expect(page).to have_content 'Make it shiny!'
    expect(page).to_not have_content 'Standards comp'

    click_link 'Make it shiny!'
    within('#ticket h2') do
      expect(page).to have_content 'Make it shiny!'
    end
    expect(page). to have_content 'Gradients!'
  end
end
