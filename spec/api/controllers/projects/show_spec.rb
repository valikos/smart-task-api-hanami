require_relative '../../../../apps/api/controllers/projects/show'

RSpec.describe Api::Controllers::Projects::Show do
  let(:action) { described_class.new }
  let(:params) { { id: 1 } }
  let(:rodauth) { double('rodauth', session_value: 1) }
  let(:account) { double('Account', id: 1) }
  let(:repository) { double('ProjectRepository', find_by_account_with_tasks: result)}
  let(:result) { double('Project') }

  before do
    allow(action).to receive(:rodauth).and_return(rodauth)
    allow(ProjectRepository).to receive(:new).and_return(repository)
  end

  it 'finds project record' do
    action.call(params)

    expect(repository).to have_received(:find_by_account_with_tasks)
  end

  context 'when user is owner of project' do
    it 'returns 200 status' do
      response = action.call(params)

      expect(response[0]).to eq 200
    end
  end

  context 'when user is not owner of project' do
    let(:result) { nil }

    it 'returns 404 status' do
      response = action.call(params)

      expect(response[0]).to eq 404
    end
  end
end
