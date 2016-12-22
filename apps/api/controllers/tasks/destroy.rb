module Api::Controllers::Tasks
  class Destroy
    include Api::Action

    def call(params)
      repository = TaskRepository.new
      task = repository.find(params[:id])

      if task
        repository.delete(task.id)
        halt 204
      else
        status 404, ''
      end
    end
  end
end
