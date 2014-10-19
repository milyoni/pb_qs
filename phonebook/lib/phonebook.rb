require 'fileutils'
require 'csv'
class PhoneBook
  attr_accessor :phonebook

  def initialize(pb = nil)
    @phonebook = pb
  end

  def create
    print "Enter a file name for the new phone book: "
    file = STDIN.gets().chomp()
    FileUtils.touch(file)
    @phonebook = file
  end

  def select
    # We're not going to show the user a list of phone books for this exercise.
    # We should, though. Something like a file browser.
    print "Type in the phone book file name: "
    @phonebook = STDIN.gets().chomp()
  end

  def print_book
    # File browser needed in a real project
    puts File.read @phonebook
  end

  def import
    print "Type in the file name that you want to import: "
    count = CSV.read(@phonebook).length
    CSV.open(@phonebook, "ab") do |csv|
      CSV.read(STDIN.gets().chomp()).each_with_index do |line, i|
        csv << [count + i + 1] + line
      end
    end
  end
end
