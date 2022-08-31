# frozen_string_literal: true

shared_examples 'repository' do
  describe '#push' do
    context 'when model has incorrect class' do
      let(:model) { 'Invalid' }

      it 'raises an error' do
        expect { repository.push(model) }.to raise_error(
          Drivy::BaseRepository::InvalidItemError,
          Drivy::BaseRepository::INVALID_ITEM_CLASS_ERROR_MESSAGE
        )
      end
    end

    context 'when model has correct class' do
      context 'when model is valid' do
        it 'returns current collection' do
          expect(repository.push(model)).to eq([model])
        end
      end

      context 'when model is invalid' do
        let(:model_id) { -1 }

        it 'raises an model validation error' do
          expect { repository.push(model) }.to raise_error(Drivy::BaseModel::ValidationError)
        end
      end
    end
  end

  describe '#reset!' do
    before { repository.push(model) }

    it 'cleans entries' do
      repository.reset!

      expect(repository.entries).to eq([])
    end
  end
end
