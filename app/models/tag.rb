# frozen_string_literal: true

class Tag < ApplicationRecord
  has_and_belongs_to_many :tasks
  validates_uniqueness_of :title
end
