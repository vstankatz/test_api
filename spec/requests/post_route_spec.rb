require 'rails_helper'

describe "post a quote route", :type => :request do

  before do
    post '/quotes', params: { :author => 'test_author', :content => 'test_content' }
  end

  it 'returns the author name' do
    expect(JSON.parse(response.body)['author']).to eq('test_author')
  end

  it 'returns the quote content' do
    expect(JSON.parse(response.body)['content']).to eq('test_content')
  end

  it 'returns a created status' do
    expect(response).to have_http_status(:created)
  end
end

describe "failed to post", :type => :request do

  it 'returns a message if the validation fails' do
    post '/quotes', params: { :author => '', :content => 'test_content' }
    expect(JSON.parse(response.body)['message']).to eq("Validation failed: Author can't be blank")
  end

  it 'returns a message if the validation fails' do
    post '/quotes', params: { :author => 'test_author', :content => '' }
    expect(JSON.parse(response.body)['message']).to eq("Validation failed: Content can't be blank")
  end
end
