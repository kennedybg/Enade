class Aluno < ActiveRecord::Base
  belongs_to :curso
  require 'csv'

  validates :nome, presence:true
  validates :email, presence:true
  validates :nota_enade, presence:true


  def self.import(file)

    CSV.foreach(file.path, headers:true) do |row|
        aluno = find_by_id(row["id"]) || new
        aluno.attributes = row.to_hash.slice(*['id','nome','email','nota_enade','curso_id','created_at','updated_at'])
        aluno.save!
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
