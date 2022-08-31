# frozen_string_literal: true

shared_examples 'rentals controller' do
  let(:input_path) { 'input_path.json' }
  let(:output_path) { 'output_path.json' }
  let(:input_hash) do
    { 'cars' => [car_hash],
      'rentals' => [rental_hash],
      'options' => options_array }
  end
  let(:input_json) { input_hash.to_json }
  let(:car_hash) { { 'id' => 1, 'price_per_day' => 2000, 'price_per_km' => 10 } }
  let(:rental_hash) do
    { 'id' => 1,
      'car_id' => 1,
      'distance' => 100,
      'start_date' => start_date,
      'end_date' => '2017-12-10' }
  end
  let(:start_date) { '2017-12-8' }
  let(:expected_output_file_data) { expected_output_hash.to_json }

  before do
    allow(File).to receive(:read).and_return(input_json)
    allow(File).to receive(:write)
  end

  shared_examples 'reads input file' do
    it 'reads input file' do
      subject

      expect(File).to have_received(:read).with(input_path)
    end
  end

  shared_examples 'processes invalid input' do
    it 'does not write to output file' do
      subject

      expect(File).not_to have_received(:write)
    end

    it 'logs failure to stdout' do
      expect { subject }.to output(/FAILED/).to_stdout
    end
  end

  context 'when correct input data' do
    it 'writes correct data' do
      subject

      expect(File).to have_received(:write).with(
        output_path, expected_output_file_data
      )
    end

    it 'logs success to stdout' do
      expect { subject }.to output(/SUCCESSFULLY FINISHED/).to_stdout
    end

    it 'logs output file to stdout' do
      expect { subject }.to output(/RESULTS FILE: output_path.json/).to_stdout
    end

    it_behaves_like 'reads input file'
  end

  context 'when incorect input data' do
    context 'when invalid date' do
      let(:start_date) { 'invalid' }

      it_behaves_like 'reads input file'
      it_behaves_like 'processes invalid input'
    end

    context 'when invalid car data' do
      let(:car_hash) { { 'invalid' => 'invalid' } }

      it_behaves_like 'reads input file'
      it_behaves_like 'processes invalid input'
    end

    context 'when invalid rental data' do
      let(:rental_hash) { { 'invalid' => 'invalid' } }

      it_behaves_like 'reads input file'
      it_behaves_like 'processes invalid input'
    end

    context 'when file contains invalid json' do
      let(:input_json) { 'invalid' }

      it_behaves_like 'reads input file'
      it_behaves_like 'processes invalid input'
    end
  end
end
