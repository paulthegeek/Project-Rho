require 'spec_helper'

describe 'publisher #index page' do
  it 'lists the publishers' do
    visit publishers_path
    page.has_selector?('table tr')
  end

  it 'goes to the new publisher page' do
    visit publishers_path
    click_link('+Publisher')
    find_field('publisher_name')
  end

  it 'creates a new publisher' do
    visit publishers_path
    click_link('+Publisher')
    fill_in('publisher_name', with: 'BOOM Studios')
    click_button('Create')
    expect(page).to have_content('BOOM Studios')
  end

  it 'goes to edit page of publisher' do
    visit publishers_path
    find('#publishers-table').click_link('DC')
    find_field('publisher_name')
  end

  it 'updates the publisher' do
    visit publishers_path
    find('#publishers-table').click_link('DC')
    fill_in('publisher_name', with: 'DC/Vertigo')
    click_button('Update')
    expect(page).to have_content('DC/Vertigo')
  end
end