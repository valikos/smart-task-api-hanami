require_relative '../../../../apps/api/controllers/project/update'

RSpec.describe Api::Controllers::Project::Update do
  let(:action) { described_class.new }
  let(:project) { double('Project', id: 1) }
  let(:updated_project) { double('Project') }
  let(:rodauth) { double('rodauth', session_value: 1) }
  let(:repository) { double('ProjectRepository', update: updated_project, find_by_user: project) }

  before do
    allow(action).to receive(:rodauth).and_return(rodauth)
  end

  context 'when acceptable params' do
    before do
      allow(ProjectRepository).to receive(:new).and_return(repository)
      allow(repository).to receive(:find_by_user).and_return(project)
      allow(repository).to receive(:update).with(project).and_return(updated_project)
    end

    let(:params) { { title: 'Testing', id: 1 } }

    it 'finds project entity' do
      action.call(params)

      expect(repository).to have_received(:find_by_user)
    end

    it 'updates project entity' do
      action.call(params)

      expect(repository).to have_received(:update)
    end

    it 'returns 200 status' do
      response = action.call(params)

      expect(response[0]).to eq 200
    end

    context 'when user is not owner of project' do
      let(:project) { nil }

      it 'returns 404 status' do
        response = action.call(params)

        expect(response[0]).to eq 404
      end
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
