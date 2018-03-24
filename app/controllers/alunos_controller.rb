class AlunosController < ApplicationController
  before_action :set_aluno, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  require 'csv'
  # GET /alunos
  # GET /alunos.json
  def index

      if session[:curso_id] == nil
        redirect_to root_url and return
      end

      @q_alunos = Aluno.ransack(params[:q].try(:merge, m:'or'))

      @q_alunos.sorts = 'nome asc' if @q_alunos.sorts.empty?
      @alunos = @q_alunos.result.where "curso_id = #{session[:curso_id]}"
      @mediaCurso = Aluno.where("curso_id = ?",session[:curso_id]).average("nota_enade")
      @alunoMaiorNota = Aluno.where("curso_id = ?",session[:curso_id]).maximum(:nota_enade)
      @alunoMenorNota = Aluno.where("curso_id = ?",session[:curso_id]).minimum(:nota_enade)

      respond_to do |format|
          format.html
          format.csv {send_data @alunos.to_csv}
      end
  end

  def import
      Aluno.import(params[:file])
      redirect_to alunos_url, notice: "Dados do arquivo importados com sucesso!"
  end

  def export
    @alunos = Aluno.where "curso_id = ?", session[:curso_id]
    respond_to do |format|
        format.html
        format.csv {send_data @alunos.to_csv, filename:"alunos_#{session[:curso_nome]}_#{session[:universidade_nome]}.csv"}
    end
  end

  # GET /alunos/1
  # GET /alunos/1.json
  def show
  end

  # GET /alunos/new
  def new
    @aluno = Aluno.new
  end

  # GET /alunos/1/edit
  def edit
  end

  # POST /alunos
  # POST /alunos.json
  def create
    @aluno = Aluno.new(aluno_params)
    @aluno.curso_id = session[:curso_id]
    respond_to do |format|
      if @aluno.save
        format.html { redirect_to alunos_path, notice: 'Aluno cadastrado com sucesso!' }
        format.json { render :show, status: :created, location: @aluno }
      else
        format.html { render :new }
        format.json { render json: @aluno.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /alunos/1
  # PATCH/PUT /alunos/1.json
  def update
    respond_to do |format|
      if @aluno.update(aluno_params)
        format.html { redirect_to alunos_path, notice: 'Aluno atualizado com sucesso!' }
        format.json { render :show, status: :ok, location: @aluno }
      else
        format.html { render :edit }
        format.json { render json: @aluno.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /alunos/1
  # DELETE /alunos/1.json
  def destroy
    @aluno.destroy
    respond_to do |format|
      format.html { redirect_to alunos_url, notice: 'Aluno removido com sucesso!' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_aluno
      @aluno = Aluno.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def aluno_params
      params.require(:aluno).permit(:nome, :email, :nota_enade, :curso_id)
    end
end
