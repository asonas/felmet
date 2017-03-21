class Api::EventsController < ApiController

  def create
    felica = Felica.find_by(idm: params[:idm])

    if felica.nil?
      felica = Felica.new(idm: params[:idm])
      felica.save
      render text: 200 and return
    end

    unless felica.activate?
      felica.touch(:updated_at)
      felica.save
      render text: 200 and return
    end

    event = felica.fetch_active_event
    if event.nil?
      Event.create!(user: felica.user, felica: felica, location_id: params[:location_id])
    else
      event.checkout!
    end
    render text: 200
  end

end
