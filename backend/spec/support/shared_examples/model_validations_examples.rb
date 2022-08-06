# frozen_string_literal: true

shared_examples 'models validations' do
  shared_examples 'raises an validation error' do |message|
    it 'raises an error' do
      expect { subject.valid? }.to raise_error(Drivy::BaseModel::ValidationError, message)
    end
  end

  shared_examples 'be valid' do
    it 'returns true' do
      expect(subject).to be_valid
    end
  end

  shared_examples 'validates presence' do |attribute_name|
    context 'with negative checks' do
      before { subject.instance_variable_set("@#{attribute_name}", value) }

      context 'when blank string' do
        let(:value) { '' }

        it_behaves_like 'raises an validation error', Regexp.new(Drivy::BaseModel::PRESENCE_VALIDATION_ERROR_MESSAGE)
      end

      context 'when nil' do
        let(:value) { nil }

        it_behaves_like 'raises an validation error', Regexp.new(Drivy::BaseModel::PRESENCE_VALIDATION_ERROR_MESSAGE)
      end

      context 'when zero' do
        let(:value) { 0 }

        it_behaves_like 'raises an validation error', Regexp.new(Drivy::BaseModel::PRESENCE_VALIDATION_ERROR_MESSAGE)
      end
    end

    context 'when non blank' do
      it_behaves_like 'be valid'
    end
  end

  shared_examples 'validates positive integer' do |attribute_name|
    context 'with negative checks' do
      before { subject.instance_variable_set("@#{attribute_name}", value) }

      context 'when non number' do
        let(:value) { 'string' }

        it_behaves_like 'raises an validation error',
                        Regexp.new(Drivy::BaseModel::POSITIVE_INTEGER_VALIDATION_ERROR_MESSAGE)
      end

      context 'when negative' do
        let(:value) { -10 }

        it_behaves_like 'raises an validation error',
                        Regexp.new(Drivy::BaseModel::POSITIVE_INTEGER_VALIDATION_ERROR_MESSAGE)
      end

      context 'when float' do
        let(:value) { 5.5 }

        it_behaves_like 'raises an validation error',
                        Regexp.new(Drivy::BaseModel::POSITIVE_INTEGER_VALIDATION_ERROR_MESSAGE)
      end
    end

    context 'when positive integer' do
      it_behaves_like 'be valid'
    end
  end

  shared_examples 'validates date' do |attribute_name|
    context 'with negative checks' do
      before { subject.instance_variable_set("@#{attribute_name}", value) }

      context 'when non date' do
        let(:value) { 'string' }

        it_behaves_like 'raises an validation error',
                        Regexp.new(Drivy::BaseModel::DATE_ERROR_MESSAGE)
      end
    end

    context 'when correct date' do
      it_behaves_like 'be valid'
    end
  end
end
