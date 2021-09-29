# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Task, type: :model do
  let(:tag) { Tag.create(title: "A Tag") }
  let(:task) { Task.create(title: "A Task") }

  describe "updating and tagging" do
    let(:new_title) { "A New Test Title" }

    it "will tag" do
      task.update_and_tag(tags: [tag.title])
      expect(Task.first.tags).to include(tag)
    end

    it "just updates if there's no tag" do
      task.update_and_tag({ title: new_title })
      expect(Task.first.title).to eq(new_title)
    end

    it "will both tag and update" do
      task.update_and_tag({ title: new_title, tags: [tag.title] })

      modified_task = Task.first
      expect(modified_task.tags).to include(tag)
      expect(modified_task.title).to eq(new_title)
    end

    it "will create missing tags" do
      tag_title = "A New Tag"
      task.update_and_tag({tags: [tag_title]})
      modified_task = Task.first

      expect(modified_task.tags.first.title).to eq(tag_title)
    end
  end

  describe "creating and tagging" do
    let(:new_title) { "A New Test Title" }

    it "creates with no tag" do
      Task.create_and_tag({ title: new_title })
      expect(Task.first.title).to eq(new_title)
    end

    it "creates with a tag" do
      Task.create_and_tag({ title: new_title, tags: [tag.title] })

      created_task = Task.first
      expect(created_task.tags).to include(tag)
      expect(created_task.title).to eq(new_title)
    end
  end
end
