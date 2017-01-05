require_relative '../../../apps/oauth/interactors/set_account_provider'

RSpec.describe SetAccountProvider do
  let(:subject) { described_class.new(params) }
  let(:params) do
    { id: 1, access_token: 'token' }
  end
  let(:repo) { double(AccountProviderRepository) }

  before do
    allow(AccountProviderRepository).to receive(:new).and_return(repo)
    allow(repo).to receive(:find).and_return(status)
  end

  context 'when new account' do
    let(:status) { false }

    before do
      allow(repo).to receive(:create)
      subject.call
    end

    it 'creates new provider record' do
      expect(repo).to have_received(:create)
    end
  end

  context 'when existing account' do
    let(:status) { true }

    before do
      allow(repo).to receive(:update)
      subject.call
    end

    it 'updates related provider record' do
      expect(repo).to have_received(:update)
    end
  end
end
