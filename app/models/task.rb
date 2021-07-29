# frozen_string_literal: true

class Task < ApplicationRecord
  has_and_belongs_to_many :tags

  def tag(*titles)
    new_tags = Tag.where(title: titles)
    tags << new_tags
  end
end
