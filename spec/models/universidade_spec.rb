require 'rails_helper'

RSpec.describe Universidade, type: :model do


  describe "Valid Universidade" do
    it "Criar objeto Universidade" do
        ies= Universidade.create(nome:'UEMG',uf:'MG', nota_geral:3)
        expect(ies).to be_truthy
    end
  end
end
