require_relative '../../../../apps/api/controllers/tasks/update'

RSpec.describe Api::Controllers::Tasks::Update do
  let(:action) { described_class.new }
  let(:rodauth) { double('rodauth', session_value: 1) }
  let(:entity) { double('Task') }
  let(:repository) { double('TaskRepository', update: entity) }

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
          id: 1,
          attributes: { title: 'Testing', id: 1 },
          relationships: {
            project: {
              data: { type: 'projects', id: 1 }
            }
          }
        }
      }
    end

    it 'updates task' do
      action.call(params)

      expect(repository).to have_received(:update)
    end

    it 'returns 200 status' do
      response = action.call(params)

      expect(response[0]).to eq 200
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
