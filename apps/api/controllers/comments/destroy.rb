module Api::Controllers::Comments
  class Destroy
    include Api::Action

    def call(params)
      repository = CommentRepository.new
      comment = repository.find(params[:id])

      if comment
        repository.delete(comment.id)
        halt 204
      else
        status 404, ''
      end
    end
  end
end
