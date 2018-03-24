class UniversidadesController < ApplicationController
  before_action :set_universidade, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  require 'csv'

  # GET /universidades
  # GET /universidades.json
  def index
    #@universidades = Universidade.order("nota_geral DESC")
    @q = Universidade.ransack(params[:q].try(:merge, m:'or'))
    @q.sorts = 'nota_geral desc' if @q.sorts.empty?
    @universidades = @q.result

    @iesMaiorNota = Universidade.maximum(:nota_geral)
    @iesMenorNota = Universidade.minimum(:nota_geral)

    respond_to do |format|
        format.html
        format.csv {send_data @universidades.to_csv}
    end
  end

  def export
    @universidades = Universidade.all
    respond_to do |format|
        format.html
        format.csv {send_data @universidades.to_csv, filename:'universidades.csv'}
    end
  end

  def import
      Universidade.import(params[:file])
      redirect_to root_url, notice: "Dados do arquivo importados com sucesso!"
  end


    def import_cursos
        Curso.import(params[:file])
        redirect_to root_url, notice: "Dados do arquivo importados com sucesso!"
    end

  # GET /universidades/1
  # GET /universidades/1.json
  def show
    session[:universidade_id] = @universidade.id
    session[:universidade_nome] = @universidade.nome
    session[:universidade_uf] = @universidade.uf
    session[:universidade_nota_geral] = @universidade.nota_geral
    redirect_to cursos_path
  end

  # GET /universidades/new
  def new
    @universidade = Universidade.new
  end

  # GET /universidades/1/edit
  def edit
  end

  def iesMaiorNota
      @iesMaiorNota = Universidade.order(:nota_geral).limit 1
  end

  # POST /universidades
  # POST /universidades.json
  def create
    @universidade = Universidade.new(universidade_params)
    respond_to do |format|
      if @universidade.save
        format.html { redirect_to @universidade, notice: 'IES cadastrada com sucesso!' }
        format.json { render :show, status: :created, location: @universidade }
      else
        format.html { render :new }
        format.json { render json: @universidade.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /universidades/1
  # PATCH/PUT /universidades/1.json
  def update
    respond_to do |format|
      if @universidade.update(universidade_params)
        format.html { redirect_to @universidade, notice: 'IES atualizada com sucesso!' }
        format.json { render :show, status: :ok, location: @universidade }
      else
        format.html { render :edit }
        format.json { render json: @universidade.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /universidades/1
  # DELETE /universidades/1.json
  def destroy
    @universidade.destroy
    respond_to do |format|
      format.html { redirect_to universidades_url, notice: 'IES removida com sucesso!' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_universidade
      @universidade = Universidade.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def universidade_params
      params.require(:universidade).permit(:nome, :uf, :nota_geral)
    end
end
