require_relative '../../../../apps/api/controllers/projects/destroy'

RSpec.describe Api::Controllers::Projects::Destroy do
  let(:action) { described_class.new }
  let(:params) { { id: 1} }
  let(:rodauth) { double('rodauth', session_value: 1) }
  let(:project) { double('Project', title: 'Testing', id: 1) }
  let(:repository) { double('ProjectRepository') }

  before do
    allow(action).to receive(:rodauth).and_return(rodauth)
    allow(ProjectRepository).to receive(:new).and_return(repository)
    allow(repository).to receive(:find_by_account).and_return(project)
    allow(repository).to receive(:delete)
  end

  it 'finds project entity' do
    action.call(params)

    expect(repository).to have_received(:find_by_account)
  end

  it 'deletes project record' do
    action.call(params)

    expect(repository).to have_received(:delete).with(project.id)
  end

  it 'returns 204 status' do
    response = action.call(params)

    expect(response[0]).to eq 204
  end

  context 'when user is not owner of project' do
    let(:project) { nil }

    it 'returns 404 status' do
     response = action.call(params)

      expect(response[0]).to eq 404
    end
  end
end
