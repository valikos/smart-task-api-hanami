require_relative '../../../../apps/api/controllers/projects/update'

RSpec.describe Api::Controllers::Projects::Update do
  let(:action) { described_class.new }
  let(:project) { double('Project', id: 1) }
  let(:updated_project) { double('Project') }
  let(:rodauth) { double('rodauth', session_value: 1) }
  let(:repository) { double('ProjectRepository', update: updated_project, find_by_account: project) }

  before do
    allow(action).to receive(:rodauth).and_return(rodauth)
  end

  context 'when acceptable params' do
    before do
      allow(ProjectRepository).to receive(:new).and_return(repository)
      allow(repository).to receive(:find_by_account).and_return(project)
      allow(repository).to receive(:update).with(project).and_return(updated_project)
    end

    let(:params) do
      {
        data: {
          type: 'projects',
          id: 1,
          attributes: { title: 'Testing' }
        }
      }
    end

    it 'finds project entity' do
      action.call(params)

      expect(repository).to have_received(:find_by_account)
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
    let(:params) do
      {
        data: {
          type: 'projects',
          id: 1,
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
