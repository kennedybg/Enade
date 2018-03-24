class Curso < ActiveRecord::Base
  require 'csv'
  belongs_to :universidade

  validates :nome, presence:true
  validates :nota, presence:true
  validates :media_alunos, presence:true

  def self.import(file)

    CSV.foreach(file.path, headers:true) do |row|
        curso = find_by_id(row["id"]) || new
        curso.attributes = row.to_hash.slice(*['id','nome','uf','nota','media_alunos','created_at','updated_at','universidade_id'])
        curso.save!
    end
  end

  def self.to_csv

      CSV.generate do |csv|
          csv << column_names
          all.each do |curso|
              csv << curso.attributes.values_at(*column_names)
          end
      end

  end
end
