require_relative '../../../../apps/api/controllers/project/index'

RSpec.describe Api::Controllers::Project::Index do
  let(:action) { described_class.new }
  let(:params) { Hash[] }
  let(:account) { double('Account', id: 1) }
  let(:rodauth) { double('rodauth', session_value: 1) }

  before do
    allow(action).to receive(:rodauth).and_return(rodauth)
    allow(ProjectRepository).to receive(:all_by_account).and_return([])
  end

  it 'finds records by account' do
    action.call(params)

    expect(ProjectRepository).to have_received(:all_by_account)
  end

  it 'returns 200 status' do
    response = action.call(params)

    expect(response[0]).to eq 200
  end
end
