require_relative '../../../../apps/api/controllers/tasks/index'

RSpec.describe Api::Controllers::Tasks::Index do
  let(:action) { described_class.new }
  let(:params) { Hash[] }
  let(:account) { double('Account', id: 1) }
  let(:rodauth) { double('rodauth', session_value: 1) }
  let(:project) { double('Project') }
  let(:repository) { double('ProjectRepository') }

  before do
    allow(action).to receive(:rodauth).and_return(rodauth)
    allow(ProjectRepository).to receive(:new).and_return(repository)
    allow(repository).to receive(:find).and_return(project)
    allow(repository).to receive(:get_tasks).and_return([])
  end

  it 'finds project by account' do
    action.call(params)

    expect(repository).to have_received(:find)
  end

  it 'gets tasks for project' do
    action.call(params)

    expect(repository).to have_received(:get_tasks).with(project)
  end

  it 'returns 200 status' do
    response = action.call(params)

    expect(response[0]).to eq 200
  end
end
