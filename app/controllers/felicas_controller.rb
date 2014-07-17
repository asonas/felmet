class FelicasController < ApplicationController
  before_action :set_felica, only: [:show, :edit, :update, :destroy]

  # GET /felicas
  # GET /felicas.json
  def index
    @felicas = Felica.all
  end

  # GET /felicas/1
  # GET /felicas/1.json
  def show
  end

  # GET /felicas/new
  def new
    @felica = Felica.new
  end

  # GET /felicas/1/edit
  def edit
  end

  # POST /felicas
  # POST /felicas.json
  def create
    @felica = Felica.new(felica_params)

    respond_to do |format|
      if @felica.save
        format.html { redirect_to @felica, notice: 'Felica was successfully created.' }
        format.json { render :show, status: :created, location: @felica }
      else
        format.html { render :new }
        format.json { render json: @felica.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /felicas/1
  # PATCH/PUT /felicas/1.json
  def update
    respond_to do |format|
      if @felica.update(felica_params)
        format.html { redirect_to @felica, notice: 'Felica was successfully updated.' }
        format.json { render :show, status: :ok, location: @felica }
      else
        format.html { render :edit }
        format.json { render json: @felica.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /felicas/1
  # DELETE /felicas/1.json
  def destroy
    @felica.destroy
    respond_to do |format|
      format.html { redirect_to felicas_url, notice: 'Felica was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_felica
      @felica = Felica.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def felica_params
      params.require(:felica).permit(:idm, :activation, :activated_at)
    end
end
