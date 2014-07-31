class Api::FelicasController < ApiController

  def create
    felica = Felica.where(idm: params[:idm]).first

    if felica.nil?
      felica = Felica.new(idm: params[:idm])
    end

    if felica.save
      render text: 200
    else
      render text: 401
    end
  end

end
