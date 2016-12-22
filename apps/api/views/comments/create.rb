module Api::Views::Comments
  class Create
    include Api::View

    format :json

    def render
      raw JSON.generate(CommentSerializer.serialize(comment, include: 'task'))
    end
  end
end
