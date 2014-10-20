require 'fileutils'
require 'csv'
require 'lib/conio'

class PhoneBook
  include ConIO
  attr_accessor :phonebook
  NUMBER = 2
  NAME = 1
  INDEX = 0

  def initialize(pb = nil)
    @phonebook = pb
  end

  def create
    file = prompt('Enter a file name for the new phone book: ')
    FileUtils.touch(file)
    @phonebook = file
  end

  def select
    # We're not going to show the user a list of phone books for this exercise.
    # We should, though. Something like a file browser.
    @phonebook = prompt('Enter the phone book file name: ')
  end

  def print_book
    # File browser needed in a real project
    # TODO Should format the output
    puts File.read @phonebook
  end

  def import
    file = prompt('Enter the file name that you want to import: ')
    count = number_of_entries
    writes do
      # each_with_index returns an Enumerator. with ruby <= 1.8.6, use the Enumerator library.
      CSV.read(file).each_with_index.map do |line, i|
        {index: count + i + 1, name: line[0], number: line[1] }
      end
    end
  end

  def write(mode="ab")
    CSV.open(@phonebook, mode) do |csv|
      line = yield
      csv << line.values_at(:index, :name, :number)
    end
  end

  def writes(mode="ab")
    CSV.open(@phonebook, mode) do |csv|
      lines = yield
      lines.each do |line|
        csv << line.values_at(:index, :name, :number)
      end
    end
  end

  def update(index, number)
    lines = read_all
    writes("wb") do
      lines.map do |line|
        line[:number] = number if line[:index] == index
        line
      end
    end
  end

  def read
    CSV.read(@phonebook).each do |line|
      yield line2hash line
    end
  end

  def read_all
    CSV.read(@phonebook).map do |line|
      line2hash(line)
    end
  end

  def add_entry(name, number)
    count = number_of_entries
    write { |csv| {index: count + 1, name: name, number: number} }
  end

  def number_of_entries
    CSV.read(@phonebook).length
  end

  private
  def line2hash(line)
    {number: line[NUMBER], name: line[NAME], index: line[INDEX]}
  end
end
