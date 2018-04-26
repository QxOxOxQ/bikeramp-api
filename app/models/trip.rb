# frozen_string_literal: true

# == Schema Information
#
# Table name: trips
#
#  id         :bigint(8)        not null, primary key
#  distance   :float
#  price      :float            not null
#  date       :date             not null
#  start      :string           not null
#  finish     :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#


class Trip < ApplicationRecord
  validates_presence_of :finish, :start, :date, :price
end
