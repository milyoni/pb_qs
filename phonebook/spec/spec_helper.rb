require 'tempfile'
require 'rspec'
require './phonebook'

RSpec.configure do |config|
  config.mock_with :rr
end


def write_temp_csv(file, data)
  name, ext = file.split('.')
  ext = '.' + ext
  csv = Tempfile.new([name, ext])
  csv.write(CSV.generate_line(data))
  csv.close
  return csv
end
