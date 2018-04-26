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


require "rails_helper"

RSpec.describe Trip, type: :model do
  describe "validations" do
    it { should validate_presence_of(:price) }
    it { should validate_presence_of(:date) }
    it { should validate_presence_of(:start) }
    it { should validate_presence_of(:finish) }
  end
end
