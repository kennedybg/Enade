require 'rails_helper'

RSpec.describe Curso, type: :model do

    let(:universidade) {
      Universidade.create(nome: 'UniTeste', uf: 'mg', nota_geral: 55.0)
    }

    describe "Valid Curso" do
      it "Criar objeto valido" do
          curso= Curso.create(nome:'Administracao',nota:4, media_alunos:4, universidade_id: universidade.id)
          expect(curso).to be_truthy
      end
    end
end
