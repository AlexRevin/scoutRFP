require 'rails_helper'

RSpec.describe 'Tag management', type: :request do
  it 'gets a list of tags' do
    Tag.create(title: 'foo')
    get '/api/v1/tags'
    expect(response.body).to have_json_path('data/0/type')
    expect(parse_json(response.body, 'data/0/attributes/title')).to eq('foo')
  end

  it 'creates a new tag' do
    post '/api/v1/tags', params: {
      data: {
        attributes: {
          title: 'bar'
        }
      }
    }.to_json,
    headers: { 'CONTENT_TYPE' => 'application/json' }
    expect(parse_json(response.body, 'data/attributes/title')).to eq('bar')
  end
  it 'updates a tag' do
    tag = Tag.create(title: 'foo')
    patch "/api/v1/tags/#{tag[:id]}", params: {
      data: {
        type: 'tags',
        id: tag[:id],
        attributes: {
          title: 'bar',
        }
      }
    }.to_json,
    headers: { 'CONTENT_TYPE' => 'application/json' }
    expect(parse_json(response.body, 'data/attributes/title')).to eq('bar')
  end
end