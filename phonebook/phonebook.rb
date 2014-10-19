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
end

class Contact
  def add_new

  end
  def find_by_name

  end
  def find_by_number

  end
end

class Menu
  attr_accessor :phonebook
  def show
    input = nil
    while !input || input != 'q'
      display_menu
      input = STDIN.gets.chomp.downcase
      process input
    end
  end

  def display_menu
    puts "\n" + '-' * 20
    puts 'S - Select phone book'
    puts 'C - Create phone book'
    if @phonebook
      puts <<-EOT
P - Print phone book
I - Import CSV file into phone book
A - Add new contact
F - Lookup numbers by name
N - Lookup names by number
      EOT
    end
    puts 'Q - Quit'
    print "-"*20 + "\nSelection: "
  end

  def process(input)
    if !@phonebook && 'piadufn'.include?(input)
      puts 'No phone books selected. Please select a phonebook.'
      return
    end

    case input
    when 'q'
      return
    when 's'
      @phonebook = PhoneBook.new
      @phonebook.select
    when 'c'
      @phonebook = PhoneBook.new
      @phonebook.create
    when 'p'
      @phonebook.print_book
    when 'i'
      @phonebook.import
    when 'a'
      Contact.add_new(@phonebook)
    when 'f'
      Contact.new(@phonebook).find_by_name
    when 'n'
      Contact.new(@phonebook).find_by_number
    else
      puts 'Invalid choice'
    end
  end
end

if __FILE__ == $0
  Menu.new.show
end
