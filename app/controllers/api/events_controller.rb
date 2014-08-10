class Api::EventsController < ApplicationController

  def create
    felica = Felica.active.find_by(idm: params[:idm])
    render text: 404 and return if felica.nil?

    event = felica.fetch_active_event
    if event.nil?
      Event.create(user: felica.user, felica: felica, location_id: params[:location_id])
    else
      event.checkout!
    end
    render text: 200
  end

end
