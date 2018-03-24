class Universidade < ActiveRecord::Base
require 'csv'
has_many :cursos

  validates :nome, presence:true
  validates :uf, presence:true
  validates :nota_geral, presence:true


def self.import(file)

  CSV.foreach(file.path, headers:true) do |row|
      universidade = find_by_id(row["id"]) || new
      universidade.attributes = row.to_hash.slice(*['id','nome','uf','nota_geral','created_at','updated_at'])
      universidade.save!
  end
end

def self.to_csv

    CSV.generate do |csv|
        csv << column_names
        all.each do |universidade|
            csv << universidade.attributes.values_at(*column_names)
        end
    end

end

end
