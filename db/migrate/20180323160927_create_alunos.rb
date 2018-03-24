class CreateAlunos < ActiveRecord::Migration
  def change
    create_table :alunos do |t|
      t.string :nome
      t.string :email
      t.decimal :nota_enade
      t.references :curso, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
