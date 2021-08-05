# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Task, type: :model do
  it "tags a task" do
    task = Task.create(title: "A Task")
    tag = Tag.create(title: "A Tag")

    task.tags << tag

    expect(Task.first.tags).to include(tag)
  end

  it "tags with a string" do
    task = Task.create(title: "A Task")
    tag = Tag.create(title: "A Tag")

    task.tag(tag.title)

    expect(Task.first.tags).to include(tag)
  end

  it "adds multiple tags" do
    task = Task.create(title: "A Task")
    tag = Tag.create(title: "A Tag")
    tag2 = Tag.create(title: "Another Tag")

    task.tag(tag.title, tag2.title)

    expect(Task.first.tags).to include(tag, tag2)
  end

  describe "updating and tagging" do
    it "will tag" do
      task = Task.create(title: "A Task")
      tag = Tag.create(title: "A Tag")
      task.update_and_tag(tags: [tag.title])

      expect(Task.first.tags).to include(tag)
    end

    it "just updates if there's no tag" do
      task = Task.create(title: "A Task")
      new_title = "A New Test Title"
      task.update_and_tag({ title: new_title })

      modified_task = Task.first
      expect(modified_task.title).to eq(new_title)
    end

    it "will both tag and update" do
      task = Task.create(title: "A Task")
      tag = Tag.create(title: "A Tag")
      new_title = "A New Test Title"
      task.update_and_tag({ title: new_title, tags: [tag.title] })

      modified_task = Task.first
      expect(modified_task.tags).to include(tag)
      expect(modified_task.title).to eq(new_title)
    end
  end
end
