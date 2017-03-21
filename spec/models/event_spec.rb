require 'rails_helper'

RSpec.describe Event, :type => :model do

  describe "#fetch_at" do
    let(:now) { DateTime.now }

    let!(:next_month) { DateTime.now + 1.month }
    let!(:prev_month) { DateTime.now - 1.month }
    let!(:user) { Fabricate(:user) }

    let(:event) { Fabricate(:event, felica: user.felica, user: user, checkin_at: now, checkout_at: now + 2.hours) }
    let(:event_next_month) { Fabricate(:event, felica: user.felica, user: user, checkin_at: next_month, checkout_at: next_month + 2.hours) }
    let(:event_prev_month) { Fabricate(:event, felica: user.felica, user: user, checkin_at: prev_month, checkout_at: prev_month + 2.hours) }

    it "should return events in this month" do
      expect(Event.fetch_at(now)).to match_array event
      expect(Event.fetch_at(now)).to_not match_array event_next_month
      expect(Event.fetch_at(now)).to_not match_array event_prev_month
    end

    it "should return events in enxt month" do
      # after_createでcheckin_atを更新しているので対処両方的にテストの中でcheckin_atを更新する
      event_next_month.update(checkin_at: next_month)
      travel_to next_month do
        expect(Event.fetch_at(next_month)).to match_array event_next_month
      end
    end
    it "should return events in prev month" do
      event_prev_month.update(checkin_at: prev_month)
      travel_to prev_month do
        expect(Event.fetch_at(prev_month)).to match_array event_prev_month
      end
    end
  end
end
