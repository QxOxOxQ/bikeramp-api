# frozen_string_literal: true

# == Schema Information
#
# Table name: trips
#
#  id                  :bigint(8)        not null, primary key
#  date                :date             not null
#  destination_address :string           not null
#  distance            :float
#  price               :float            not null
#  start_address       :string           not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

require "rails_helper"

RSpec.describe Trip, type: :model do
  describe "validations" do
    it { should validate_presence_of(:price) }
    it { should validate_presence_of(:date) }
    it { should validate_presence_of(:start_address) }
    it { should validate_presence_of(:destination_address) }
  end
end
