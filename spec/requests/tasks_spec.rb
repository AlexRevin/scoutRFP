require 'rails_helper'

RSpec.describe 'Task management', type: :request do
  it 'gets a list of tasks' do
    Task.create(title: 'foo')
    get '/api/v1/tasks'
    expect(response.body).to have_json_path('data/0/type')
    expect(parse_json(response.body, 'data/0/attributes/title')).to eq('foo')
  end

  it 'creates a new task' do
    post '/api/v1/tasks', params: {
      data: {
        attributes: {
          title: 'bar'
        }
      }
    }.to_json,
    headers: { "CONTENT_TYPE" => "application/json" }
    expect(response.body).to have_json_path('data/attributes/title')
    expect(parse_json(response.body, 'data/attributes/title')).to eq('bar')
  end

  it 'creates a new task with tags' do
    post '/api/v1/tasks', params: { 
      data: {
        attributes: {
          title: 'bar',
          tags: ['tag']
        }
      }
    }.to_json,
      headers: { "CONTENT_TYPE" => "application/json" }
    expect(response.body).to have_json_path('data/relationships/tags/data/0/')
  end
end
