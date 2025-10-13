json.extract! task, :id, :tittle, :body, :weight, :created_at, :updated_at
json.url task_url(task, format: :json)
