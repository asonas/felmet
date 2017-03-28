require 'rails_helper'

RSpec.describe Event, :type => :model do
  describe ".sum_enrollment_time" do
    subject { Event.sum_enrollment_time Event.all }
    let!(:user) { Fabricate(:user) }
    context "総在籍時間が59秒以下" do
      context "レコードが1件のとき" do
        before do
          datetime = DateTime.new(2017, 3, 1)
          Fabricate(:event, checkin_at: datetime, checkout_at: datetime + 59.seconds, user_id: user.id, felica_id: user.felica.id)
        end

        it { expect(subject).to eql "0時間0分" }
      end

      context "レコードが複数件のとき" do
        before do
          datetime = DateTime.new(2017, 3, 1)
          Fabricate(:event, checkin_at: datetime, checkout_at: datetime + 29.seconds, user_id: user.id, felica_id: user.felica.id)
          datetime = DateTime.new(2017, 3, 2)
          Fabricate(:event, checkin_at: datetime, checkout_at: datetime + 30.seconds, user_id: user.id, felica_id: user.felica.id)
        end

        it { expect(subject).to eql "0時間0分" }
      end
    end

    context "総在籍時間が60秒以上" do
      context "レコードが1件のとき" do
        before do
          datetime = DateTime.new(2017, 3, 1)
          Fabricate(:event, checkin_at: datetime, checkout_at: datetime + 60.seconds, user_id: user.id, felica_id: user.felica.id)
        end

        it { expect(subject).to eql "0時間1分" }
      end

      context "レコードが複数件のとき" do
        before do
          datetime = DateTime.new(2017, 3, 1)
          Fabricate(:event, checkin_at: datetime, checkout_at: datetime + 30.seconds, user_id: user.id, felica_id: user.felica.id)
          datetime = DateTime.new(2017, 3, 2)
          Fabricate(:event, checkin_at: datetime, checkout_at: datetime + 30.seconds, user_id: user.id, felica_id: user.felica.id)
        end

        it { expect(subject).to eql "0時間1分" }
      end
    end
    context "総在籍時間が59分未満" do
      before do
        datetime = DateTime.new(2017, 3, 1)
        Fabricate(:event, checkin_at: datetime, checkout_at: datetime + 49.minutes, user_id: user.id, felica_id: user.felica.id)
        datetime = DateTime.new(2017, 3, 2)
        Fabricate(:event, checkin_at: datetime, checkout_at: datetime + 10.minutes, user_id: user.id, felica_id: user.felica.id)
      end

      it { expect(subject).to eql "0時間59分" }
    end
    context "総在籍時間が1時間以上" do
      before do
        datetime = DateTime.new(2017, 3, 1)
        Fabricate(:event, checkin_at: datetime, checkout_at: datetime + 50.minutes, user_id: user.id, felica_id: user.felica.id)
        datetime = DateTime.new(2017, 3, 2)
        Fabricate(:event, checkin_at: datetime, checkout_at: datetime + 10.minutes, user_id: user.id, felica_id: user.felica.id)
      end

      it { expect(subject).to eql "1時間0分" }
    end
    context "総在籍時間が23時間59分以下" do
      before do
        datetime = DateTime.new(2017, 3, 1)
        Fabricate(:event, checkin_at: datetime, checkout_at: datetime + 23.hours, user_id: user.id, felica_id: user.felica.id)
        datetime = DateTime.new(2017, 3, 2)
        Fabricate(:event, checkin_at: datetime, checkout_at: datetime + 59.minutes, user_id: user.id, felica_id: user.felica.id)
      end

      it { expect(subject).to eql "23時間59分" }
    end
    context "総在籍時間が24時間以上" do
      before do
        datetime = DateTime.new(2017, 3, 1)
        Fabricate(:event, checkin_at: datetime, checkout_at: datetime + 23.hours, user_id: user.id, felica_id: user.felica.id)
        datetime = DateTime.new(2017, 3, 2)
        Fabricate(:event, checkin_at: datetime, checkout_at: datetime + 60.minutes, user_id: user.id, felica_id: user.felica.id)
      end

      it { expect(subject).to eql "24時間0分" }
    end
  end

  describe "#calculate_enrollment_time" do
    let(:user) { Fabricate(:user) }
    let(:event) { Fabricate(:event, felica: user.felica, user: user, checkin_at: checkin_at, checkout_at: checkout_at) }
    before do
      event.calculate_enrollment_seccond
    end

    context "1分間在籍しているとき" do
      let(:checkin_at) { DateTime.now }
      let(:checkout_at) { checkin_at + 1.minutes }

      it { expect(event.enrollment_time).to eql "00時間01分" }
    end

    context "1時間在籍しているとき" do
      let(:checkin_at) { DateTime.now }
      let(:checkout_at) { checkin_at + 1.hour }

      it { expect(event.enrollment_time).to eql "01時間00分" }
    end

    context "1時間30分在籍しているとき" do
      let(:checkin_at) { DateTime.now }
      let(:checkout_at) { checkin_at + 1.hour + 30.minutes}

      it { expect(event.enrollment_time).to eql "01時間30分" }
    end

    context "24時間以上在籍しているとき" do
      let(:checkin_at) { DateTime.now }
      let(:checkout_at) { checkin_at + 24.hours + 30.minutes }

      it { expect(event.enrollment_time).to eql "チェックアウトをしていません。" }
    end
  end

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
