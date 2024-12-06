require 'csv'

class FileConverter
  VALUE_DATA_START_I = 6
  COLUMN_INDICES = { sample: 1, oxidation: 3, nitration: 4 }

  def initialize(input_file, output_file)
    @input_file = input_file
    @output_file = output_file
  end

  def convert
    CSV.open(@output_file, 'w') do |output_csv|
      CSV.foreach(@input_file).with_index do |row, i|
        next if i < VALUE_DATA_START_I # skip headers

        output_csv << transform_row(row)
      end
    end
  end

  private

  def transform_row(row)
    [
      row[COLUMN_INDICES[:sample]],
      (row[COLUMN_INDICES[:oxidation]].to_f * 100).round,
      (row[COLUMN_INDICES[:nitration]].to_f * 100).round
    ]
  end
end

FileConverter.new('13-57-08 11-40-17 2s140519.csv', 'output.csv').convert
