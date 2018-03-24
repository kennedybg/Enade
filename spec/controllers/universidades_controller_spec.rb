require 'rails_helper'

RSpec.describe UniversidadesController, type: :controller do

  let(:aluno) {
    Aluno.create(nome: 'kennedy', email: 'kennedy@example.com', nota_enade: 4.0)
  }

  let(:universidade) {
    Universidade.create(nome: 'UniTeste', uf: 'mg', nota_geral: 55.0)
  }

  let(:curso) {
    Curso.create(nome: "Teste", nota: 10, media_alunos: 10, universidade_id: universidade.id)
  }

  let(:aluno) {
    Aluno.create(nome:'James',email:'james@gmail.com', nota_enade:4, curso_id: :curso.id)
  }

  let(:valid_session) {
    { curso_id: curso.id, universidade_id: universidade.id }
  }

  describe "GET #index" do
    it "returns a success response" do
      get :index, {}, valid_session
      expect(response).to be_success
    end
  end

end
