require_relative '../lib/computer'

describe Computer do
  describe '#create_code' do
    subject(:computer_creating_code) { described_class.new }

    it 'calls the generate_code method' do
      expect(computer_creating_code).to receive(:generate_code)
      computer_creating_code.create_code
    end
  end

  describe '#shuffle_code?' do
    context 'when there is at least one nil value in code' do
      subject(:computer_one_nil) { described_class.new }

      it 'returns false' do
        expect(computer_one_nil.shuffle_code?).to be false
      end
    end

    context 'when there are no nil values in code' do
      subject(:computer_zero_nil) { described_class.new }

      it 'returns true' do
        code = %w[a b c d e f]
        result = computer_zero_nil.shuffle_code?(code)
        expect(result).to be true
      end
    end
  end

  describe '#color_in_code?' do
    context 'when the color is not in code' do
      subject(:computer_color_not_code) { described_class.new }

      it 'returns false' do
        color = 'navy'
        code = %w[red green blue white pink orange]
        result = computer_color_not_code.color_in_code?(code, color)
        expect(result).to be false
      end
    end

    context 'when the color is in code' do
      subject(:computer_color_in_code) { described_class.new }

      it 'returns true' do
        color = 'purple'
        code = %w[brown gray purple yellow red blue]
        result = computer_color_in_code.color_in_code?(code, color)
        expect(result).to be true
      end
    end
  end
end
