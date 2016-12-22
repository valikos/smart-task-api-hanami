require_relative '../../../../apps/api/controllers/projects/create'

RSpec.describe Api::Controllers::Projects::Create do
  let(:action) { described_class.new }
  let(:entity) { double('Project') }
  let(:rodauth) { double('rodauth', session_value: 1) }
  let(:repository) { double('ProjectRepository', create: entity) }

  before do
    allow(action).to receive(:rodauth).and_return(rodauth)
  end

  context 'when acceptable params' do
    before do
      allow(ProjectRepository).to receive(:new).and_return(repository)
    end

    let(:params) do
      {
        data: {
          type: 'projects',
          attributes: { title: 'Testing' }
        }
      }
    end

    it 'creates new project' do
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
          type: 'projects',
          attributes: { title: 'T'*141 }
        }
      }
    end

    it 'returns 403 status' do
      response = action.call(params)

      expect(response[0]).to eq 403
    end
  end
end
