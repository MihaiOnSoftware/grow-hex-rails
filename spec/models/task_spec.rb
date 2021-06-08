# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Task, type: :model do
  it "tags a task" do
    task = Task.create(title: "A Task")
    tag = Tag.create(title: "A Tag")

    task.tags << tag

    expect(Task.first.tags).to include(tag)
  end
end
