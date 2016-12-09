require_relative '../../../../apps/api/controllers/tasks/destroy'

RSpec.describe Api::Controllers::Tasks::Destroy do
  let(:action) { described_class.new }
  let(:params) { Hash[] }

  let(:action) { described_class.new }
  let(:params) { { id: 1} }
  let(:rodauth) { double('rodauth', session_value: 1) }
  let(:task) { double('Task', title: 'Testing', id: 1) }
  let(:repository) { double('TaskRepository') }

  before do
    allow(action).to receive(:rodauth).and_return(rodauth)
    allow(TaskRepository).to receive(:new).and_return(repository)
    allow(repository).to receive(:find).and_return(task)
    allow(repository).to receive(:delete)
  end

  it 'finds task entity' do
    action.call(params)

    expect(repository).to have_received(:find)
  end

  it 'deletes task record' do
    action.call(params)

    expect(repository).to have_received(:delete).with(task.id)
  end

  it 'returns 204 status' do
    response = action.call(params)

    expect(response[0]).to eq 204
  end

  context 'when can not find task' do
    let(:task) { nil }

    it 'returns 404 status' do
     response = action.call(params)

      expect(response[0]).to eq 404
    end
  end
end
