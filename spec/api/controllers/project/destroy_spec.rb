require_relative '../../../../apps/api/controllers/project/destroy'

RSpec.describe Api::Controllers::Project::Destroy do
  let(:action) { described_class.new }
  let(:params) { { id: 1} }
  let(:rodauth) { double('rodauth', session_value: 1) }
  let(:project) { double('Project', title: 'Testing', id: 1) }

  before do
    allow(action).to receive(:rodauth).and_return(rodauth)
    allow(ProjectRepository).to receive(:find).and_return(project)
    allow(ProjectRepository).to receive(:delete).with(project)
  end

  it 'finds project entity' do
    action.call(params)

    expect(ProjectRepository).to have_received(:find).with(params[:id])
  end

  it 'deletes project record' do
    action.call(params)

    expect(ProjectRepository).to have_received(:delete).with(project)
  end

  it 'is successful' do
    response = action.call(params)

    expect(response[0]).to eq 200
  end
end
