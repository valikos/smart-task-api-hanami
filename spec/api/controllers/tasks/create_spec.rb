require_relative '../../../../apps/api/controllers/tasks/create'

RSpec.describe Api::Controllers::Tasks::Create do
  let(:action) { described_class.new }
  let(:rodauth) { double('rodauth', session_value: 1) }
  let(:entity) { double('Task') }
  let(:repository) { double('TaskRepository', create: entity) }

  before do
    allow(action).to receive(:rodauth).and_return(rodauth)
  end

  context 'when acceptable params' do
    before do
      allow(TaskRepository).to receive(:new).and_return(repository)
    end

    let(:params) do
      {
        data: {
          type: 'tasks',
          attributes: { title: 'Testing' },
          relationships: {
            project: {
              data: { type: 'projects', id: 1 }
            }
          }
        }
      }
    end

    it 'creates new task' do
      action.call(params)

      expect(repository).to have_received(:create)
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
          type: 'tasks',
          attributes: { title: 'Testing' }
        }
      }
    end

    it 'returns 403 status' do
      response = action.call(params)

      expect(response[0]).to eq 403
    end
  end
end
