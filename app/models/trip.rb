# frozen_string_literal: true

class Trip < ApplicationRecord
  validates_presence_of :finish, :start, :date, :price
end
