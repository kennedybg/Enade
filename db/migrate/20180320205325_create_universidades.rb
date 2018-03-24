class CreateUniversidades < ActiveRecord::Migration
  def change
    create_table :universidades do |t|
      t.string :nome
      t.string :uf
      t.decimal :nota_geral

      t.timestamps null: false
    end
  end
end
