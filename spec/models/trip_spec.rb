# frozen_string_literal: true

require "rails_helper"

RSpec.describe Trip, type: :model do
  describe "validations" do
    it { should validate_presence_of(:price) }
    it { should validate_presence_of(:date) }
    it { should validate_presence_of(:start) }
    it { should validate_presence_of(:finish) }
  end
end
