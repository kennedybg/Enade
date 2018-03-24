class CreateCursos < ActiveRecord::Migration
  def change
    create_table :cursos do |t|
      t.string :nome
      t.decimal :nota
      t.decimal :media_alunos
      t.references :universidade, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
