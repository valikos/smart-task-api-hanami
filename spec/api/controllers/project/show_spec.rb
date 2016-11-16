require_relative '../../../../apps/api/controllers/project/show'

RSpec.describe Api::Controllers::Project::Show do
  let(:action) { described_class.new }
  let(:params) { { id: 1 } }
  let(:account) { double('Account', id: 1) }
  let(:rodauth) { double('rodauth', session_value: 1) }

  before do
    allow(action).to receive(:rodauth).and_return(rodauth)
    allow(ProjectRepository).to receive(:find).with(params[:id])
  end

  it 'finds project record' do
    action.call(params)

    expect(ProjectRepository).to have_received(:find).with(1)
  end

  it 'returns 200 status' do
    response = action.call(params)

    expect(response[0]).to eq 200
  end
end
