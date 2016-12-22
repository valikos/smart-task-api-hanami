require_relative '../../../../apps/api/controllers/comments/create'

RSpec.describe Api::Controllers::Comments::Create do
  let(:action) { described_class.new }
  let(:rodauth) { double('rodauth', session_value: 1) }
  let(:task) { double('Task') }
  let(:comment) { double('Comment', to_hash: {}) }
  let(:repository) { double('TaskRepository') }

  before do
    allow(action).to receive(:rodauth).and_return(rodauth)
  end

  context 'when acceptable params' do
    before do
      allow(TaskRepository).to receive(:new).and_return(repository)
      allow(repository).to receive(:find).and_return(task)
      allow(repository).to receive(:add_comment).and_return(comment)
    end

    let(:params) do
      {
        data: {
          type: 'comments',
          attributes: { body: 'Testing' },
          relationships: {
            task: {
              data: { type: 'tasks', id: 1 }
            }
          }
        }
      }
    end

    it 'finds related task' do
      action.call(params)

      expect(repository).to have_received(:find)
    end

    it 'creates new comment' do
      action.call(params)

      expect(repository).to have_received(:add_comment)
    end

    it 'returns 201 status' do
      response = action.call(params)

      expect(response[0]).to eq 201
    end
  end

  context 'when unacceptable params' do
    let(:params) do
      {
        data: {
          type: 'comments',
          attributes: { body: 'Testing' }
        }
      }
    end

    it 'returns 403 status' do
      response = action.call(params)

      expect(response[0]).to eq 403
    end
  end
end
