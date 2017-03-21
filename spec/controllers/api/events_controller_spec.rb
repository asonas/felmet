require 'rails_helper'

RSpec.describe Api::EventsController, :type => :controller do

  describe "GET create" do
    context "with not find felica" do
      it "should create felica" do
        expect{ get :create, id: nil, idm: "test" }.to change(Felica, :count).by(1)
      end
    end

    context "with not activate felica" do
      let!(:felica) { Fabricate(:felica, idm: "test") }

      it "should update in updated_at" do
        Timecop.freeze(Date.today + 1) do
          get :create, id: nil, idm: "test"
          felica.reload
          expect(felica.updated_at).to_not eql felica.created_at
        end
      end
    end

    context "with acticated felica" do
      let!(:user) { Fabricate(:user_with_activated_felica) }
      let!(:felica) { user.felica }
      let!(:location) { Fabricate(:location) }

      it "should create event" do
        expect{ get :create, id: nil, idm: felica.idm, location_id: location.id }.to change(Event, :count).by(1)
      end
    end
  end

end
