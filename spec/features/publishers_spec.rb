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
    expect(current_path).to eq(publishers_path)
  end
end