class Api::FelicasController < ApiController

  def create
    felica = Felica.new(idm: params[:idm])
    if felica.save
      render text: 200
    else
      render text: 401
    end
  end

end
