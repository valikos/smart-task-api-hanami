require_relative '../../../../apps/api/controllers/comments/destroy'

RSpec.describe Api::Controllers::Comments::Destroy do
  let(:action) { described_class.new }
  let(:params) { Hash[] }

  let(:action) { described_class.new }
  let(:params) { { id: 1} }
  let(:rodauth) { double('rodauth', session_value: 1) }
  let(:comment) { double('Comment', id: 1) }
  let(:repository) { double('CommentRepository') }

  before do
    allow(action).to receive(:rodauth).and_return(rodauth)
    allow(CommentRepository).to receive(:new).and_return(repository)
    allow(repository).to receive(:find).and_return(comment)
    allow(repository).to receive(:delete)
  end

  it 'finds comment entity' do
    action.call(params)

    expect(repository).to have_received(:find)
  end

  it 'deletes comment record' do
    action.call(params)

    expect(repository).to have_received(:delete).with(comment.id)
  end

  it 'returns 204 status' do
    response = action.call(params)

    expect(response[0]).to eq 204
  end

  context 'when can not find task' do
    let(:comment) { nil }

    it 'returns 404 status' do
     response = action.call(params)

      expect(response[0]).to eq 404
    end
  end
end
