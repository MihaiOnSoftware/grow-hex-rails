# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tag, type: :model do
  it "titles are unique" do
    tag_title = "A title"
    Tag.create(title: tag_title)
    non_unique_tag = Tag.new(title: tag_title)

    non_unique_tag.save

    expect(non_unique_tag.errors).not_to be_empty
  end

  it "title uniqueness is enforced in the database" do
    tag_title = "A title"
    Tag.create(title: tag_title)
    non_unique_tag = Tag.new(title: tag_title)

    expect { non_unique_tag.save(validate: false) }.to raise_error(ActiveRecord::RecordNotUnique)
  end
end
