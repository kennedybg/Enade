json.extract! aluno, :id, :nome, :email, :nota_enade, :curso_id, :created_at, :updated_at
json.url aluno_url(aluno, format: :json)
