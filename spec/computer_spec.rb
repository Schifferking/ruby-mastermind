require_relative '../lib/computer'

describe Computer do
  describe '#create_code' do
    subject(:computer_creating_code) { described_class.new }
    
    it 'calls the generate_code method' do
      expect(computer_creating_code).to receive(:generate_code)
      computer_creating_code.create_code
    end
  end
end
