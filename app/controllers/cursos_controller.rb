class CursosController < ApplicationController
  before_action :set_curso, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  require 'csv'
  # GET /cursos
  # GET /cursos.json
  def index

    if session[:universidade_id] == nil
      redirect_to root_url and return
    end

    @q_cursos = Curso.ransack(params[:q].try(:merge, m:'or'))

    @q_cursos.sorts = 'nome asc' if @q_cursos.sorts.empty?
    @cursos = @q_cursos.result.where "universidade_id = #{session[:universidade_id]}"

    @cursos.each do |curso|
      curso.media_alunos = Aluno.where("curso_id = ?",curso.id).average("nota_enade")
      curso.save
    end

    @cursoMaiorNota = Curso.where("universidade_id = ?",session[:universidade_id]).maximum(:nota)
    @cursoMenorNota = Curso.where("universidade_id = ?",session[:universidade_id]).minimum(:nota)

    respond_to do |format|
        format.html
        format.csv {send_data @cursos.to_csv}
    end
  end


  def import
      Curso.import(params[:file])
      redirect_to cursos_url, notice: "Dados do arquivo importados com sucesso!"
  end

  def export
    @cursos = Curso.where "universidade_id = ?", session[:universidade_id]
    respond_to do |format|
        format.html
        format.csv {send_data @cursos.to_csv, filename:"cursos_#{session[:universidade_nome]}.csv"}
    end
  end


  # GET /cursos/1
  # GET /cursos/1.json
  def show
    session[:curso_id] = @curso.id
    session[:curso_nome] = @curso.nome
    session[:curso_nota] = @curso.nota
    session[:curso_media] = @curso.media_alunos
    redirect_to alunos_path
  end

  # GET /cursos/new
  def new
    @curso = Curso.new
  end

  # GET /cursos/1/edit
  def edit

  end

  # POST /cursos
  # POST /cursos.json
  def create
    @curso = Curso.new(curso_params)
    @curso.universidade_id = session[:universidade_id]
    @curso.media_alunos = 0
    respond_to do |format|
      if @curso.save
        format.html { redirect_to cursos_path, notice: 'Curso criado com sucesso!' }
        format.json { render :show, status: :created, location: @curso }
      else
        format.html { render :new }
        format.json { render json: @curso.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cursos/1
  # PATCH/PUT /cursos/1.json
  def update
    respond_to do |format|
      if @curso.update(curso_params)
        format.html { redirect_to cursos_path, notice: 'Curso atualizado com sucesso!' }
        format.json { render :show, status: :ok, location: @curso }
      else
        format.html { render :edit }
        format.json { render json: @curso.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cursos/1
  # DELETE /cursos/1.json
  def destroy
    @curso.destroy
    respond_to do |format|
      format.html { redirect_to cursos_url, notice: 'Curso removido com sucesso!' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_curso
      @curso = Curso.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def curso_params
      params.require(:curso).permit(:nome, :nota)
    end
end
