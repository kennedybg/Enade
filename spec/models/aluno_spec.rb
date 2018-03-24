require 'rails_helper'

RSpec.describe Aluno, type: :model do


  let(:curso) {
    Curso.create(nome: "Teste", nota: 10, media_alunos: 10, universidade_id: universidade.id)
  }

  describe "Valid Aluno" do
    it "Criar objeto valido" do
        aluno = Aluno.create(nome:'James',email:'james@gmail.com', nota_enade:4, curso_id: curso.id)
        expect(aluno).to be_truthy
    end
  end
end
