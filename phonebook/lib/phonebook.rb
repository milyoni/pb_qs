require 'fileutils'
require 'csv'
require 'lib/conio'

class PhoneBook
  include ConIO
  attr_accessor :phonebook

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
    write do |csv|
      CSV.read(file).each_with_index {|line, i| csv << [count + i + 1] + line }
    end
  end

  def write(mode="ab")
    CSV.open(@phonebook, mode) { |csv| yield csv }
  end

  def read
    CSV.read(@phonebook).each { |line| yield line }
  end

  def add_entry(name, number)
    count = number_of_entries
    write { |csv| csv << [count + 1, name, number] }
  end

  def number_of_entries
    CSV.read(@phonebook).length
  end
end
