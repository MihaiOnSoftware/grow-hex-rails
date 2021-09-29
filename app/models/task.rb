# frozen_string_literal: true

class Task < ApplicationRecord
  has_and_belongs_to_many :tags

  class << self
    def create_and_tag(tags: [], **args)
      new_tags = Tag.where(title: tags)
      create(tags: new_tags, **args)
    end
  end

  def update_and_tag(tags: [], **args)
    created_tags = Tag.where(title: tags)
    new_tag_titles = tags - created_tags.map(&:title)
    new_tags = Tag.create!(new_tag_titles.map { |title| {title: title} })
    update(tags: created_tags + new_tags, **args)
  end
end
