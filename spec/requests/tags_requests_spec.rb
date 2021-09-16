# frozen_string_literal: true

require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe '/tags', type: :request do
  # Tag. As you add validations to Tag, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) do
    {
      title: "A Title"
    }
  end

  let(:invalid_attributes) do
    {
      not_a_title: "Not A Title"
    }
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      Tag.create! valid_attributes
      get tags_url, headers: { accept: 'application/json' }
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    let(:tag) { Tag.create! valid_attributes }

    it 'renders a successful response' do
      get tag_url(tag), headers: { accept: 'application/json' }
      expect(response).to be_successful
    end

    it 'returns a json with a tag' do
      get tag_url(tag), headers: { accept: 'application/json' }
      expect(JSON.parse(response.body)).to eq(tag.attributes.slice('id', 'title').merge("tasks" => []))
    end

    it 'includes task titles in the json if available' do
      task = Task.create!(title: 'A Task')
      task2 = Task.create!(title: 'Another Task')
      tag.tasks << [task, task2]

      get tag_url(tag), headers: { accept: 'application/json' }

      tag_attributes = tag.attributes.slice("id", "title")
      tasks_attribute_array = [task, task2].map { |task| {"id" => task.id, "title" => task.title} }
      tasks_attributes = { "tasks" => tasks_attribute_array }
      expect(JSON.parse(response.body)).to eq(tag_attributes.merge(tasks_attributes))
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Tag' do
        expect do
          post tags_url, params: { tag: valid_attributes }, headers: { accept: 'application/json' }
        end.to change(Tag, :count).by(1)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Tag' do
        expect do
          post tags_url, params: { tag: invalid_attributes }, headers: { accept: 'application/json' }
        end.to change(Tag, :count).by(0)
      end

      it 'renders a unsuccessful response' do
        post tags_url, params: { tag: invalid_attributes }, headers: { accept: 'application/json' }
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        {
          title: "A New Title"
        }
      end

      it 'updates the requested tag' do
        tag = Tag.create! valid_attributes
        patch tag_url(tag), params: { tag: new_attributes }, headers: { accept: 'application/json' }
        tag.reload
        expect(tag.title).to eq('A New Title')
      end

      it 'responds with the updated tag' do
        tag = Tag.create! valid_attributes
        patch tag_url(tag), params: { tag: new_attributes }, headers: { accept: 'application/json' }
        expect(response.body).to include('A New Title')
      end
    end

    context 'with invalid parameters' do
      it 'does not update the tag' do
        tag = Tag.create! valid_attributes
        original_title = tag.title

        patch tag_url(tag), params: { tag: invalid_attributes }, headers: { accept: 'application/json' }
        tag.reload

        expect(tag.title).to eq(original_title)
      end

      it 'responds with a bad request' do
        tag = Tag.create! valid_attributes
        patch tag_url(tag), params: { tag: invalid_attributes }, headers: { accept: 'application/json' }
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested tag' do
      tag = Tag.create! valid_attributes
      expect do
        delete tag_url(tag), headers: { accept: 'application/json' }
      end.to change(Tag, :count).by(-1)
    end
  end
end
