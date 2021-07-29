# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Task, type: :model do
  it "tags a task" do
    task = Task.create(title: "A Task")
    tag = Tag.create(title: "A Tag")

    task.tags << tag

    expect(Task.first.tags).to include(tag)
  end

  it "can tag with a string" do
    task = Task.create(title: "A Task")
    tag = Tag.create(title: "A Tag")

    task.tag(tag.title)

    expect(Task.first.tags).to include(tag)
  end

  it "can add multiple tags" do
    task = Task.create(title: "A Task")
    tag = Tag.create(title: "A Tag")
    tag2 = Tag.create(title: "Another Tag")

    task.tag(tag.title, tag2.title)

    expect(Task.first.tags).to include(tag, tag2)
  end
end
