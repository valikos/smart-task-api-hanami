require_relative '../../../../apps/api/controllers/project/update'

RSpec.describe Api::Controllers::Project::Update do
  let(:action) { described_class.new }
  let(:project_entity) { double('Project') }
  let(:rodauth) { double('rodauth', session_value: 1) }

  before do
    allow(action).to receive(:rodauth).and_return(rodauth)
  end

  context 'when acceptable params' do
    before do
      allow(ProjectRepository).to receive(:find).and_return(project_entity)
      allow(project_entity).to receive(:update)
      allow(ProjectRepository).to receive(:update)
    end

    let(:params) { { title: 'Testing', id: 1 } }

    it 'finds project entity' do
      action.call(params)

      expect(ProjectRepository).to have_received(:find)
    end

    it 'updates project entity' do
      action.call(params)

      expect(project_entity).to have_received(:update)
    end

    it 'creates new project' do
      action.call(params)

      expect(ProjectRepository).to have_received(:update).with(project_entity)
    end

    it 'returns 200 status' do
      response = action.call(params)

      expect(response[0]).to eq 200
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
