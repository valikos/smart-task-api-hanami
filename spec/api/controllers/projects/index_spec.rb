require_relative '../../../../apps/api/controllers/projects/index'

RSpec.describe Api::Controllers::Projects::Index do
  let(:action) { described_class.new }
  let(:params) { Hash[] }
  let(:account) { double('Account', id: 1) }
  let(:rodauth) { double('rodauth', session_value: 1) }
  let(:repository) { double('ProjectRepository', all_by_account: []) }

  before do
    allow(action).to receive(:rodauth).and_return(rodauth)
    allow(ProjectRepository).to receive(:new).and_return(repository)
  end

  it 'finds records by account' do
    action.call(params)

    expect(repository).to have_received(:all_by_account)
  end

  it 'returns 200 status' do
    response = action.call(params)

    expect(response[0]).to eq 200
  end
end
