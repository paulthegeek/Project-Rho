require 'spec_helper'

describe 'External request' do
  it 'get this Wednesday date' do
    worker = ReleaseDateWorker.new
    today = Date.today
    expect(worker.this_wednesday_date).to eq Date.today
  end

  it 'get next week Wednesday date' do
    worker = ReleaseDateWorker.new
    a_wednesday = Date.today
    expect(worker.next_wednesday_date).to equal_same_time_as 1.week.from_now
  end

  it 'POST to comic release dates' do
    uri = URI('http://www.midtowncomics.com/store/ajax_wr_online.asp?cat=61&wdate=4/23/2014')
    response = Net::HTTP.post_form(uri, q: 'ruby', max: '50')
    expect(response).to be_an_instance_of(Net::HTTPOK)
  end
end
