require 'rails_helper'

RSpec.describe Felica, :type => :model do
  describe "#activate?" do
    context "with true" do
      let(:felica) { Fabricate(:felica, { idm: Faker::Lorem.characters, activation: true }) }
      it "should return true" do
        expect(felica.activation).to eql true
      end
    end

    context "with false or invalid characters" do
      let(:felica1) { Fabricate(:felica, { idm: Faker::Lorem.characters, activation: false }) }

      it "should return false" do
        expect(felica1.activation).to eql false
      end
    end
  end
end
