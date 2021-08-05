# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Task, type: :model do
  let(:tag) { Tag.create(title: "A Tag") }
  let(:task) { Task.create(title: "A Task") }

  it "tags a task" do
    task.tags << tag
    expect(Task.first.tags).to include(tag)
  end

  it "tags with a string" do
    task.tag(tag.title)
    expect(Task.first.tags).to include(tag)
  end

  it "adds multiple tags" do
    tag2 = Tag.create(title: "Another Tag")
    task.tag(tag.title, tag2.title)
    expect(Task.first.tags).to include(tag, tag2)
  end

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
