# frozen_string_literal: true

class Trip < ApplicationRecord
  validates_presence_of :end, :start, :date, :price
end
