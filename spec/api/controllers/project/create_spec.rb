require_relative '../../../../apps/api/controllers/project/create'

RSpec.describe Api::Controllers::Project::Create do
  let(:action) { described_class.new }
  let(:project_entity) { double('Project') }
  let(:rodauth) { double('rodauth', session_value: 1) }

  before do
    allow(action).to receive(:rodauth).and_return(rodauth)
  end

  context 'when acceptable params' do
    before do
      allow(Project).to receive(:new).and_return(project_entity)
      allow(ProjectRepository).to receive(:create)
    end

    let(:params) { { title: 'Testing' } }

    it 'creates record entity' do
      action.call(params)

      expect(Project).to have_received(:new)
    end

    it 'creates new project' do
      action.call(params)

      expect(ProjectRepository).to have_received(:create).with(project_entity)
    end

    it 'returns 201 status' do
      response = action.call(params)

      expect(response[0]).to eq 201
    end
  end

  context 'when unacceptable params' do
    let(:params) { { title: 's'*141 } }

    it 'returns 403 status' do
      response = action.call(params)

      expect(response[0]).to eq 403
    end
  end
end
