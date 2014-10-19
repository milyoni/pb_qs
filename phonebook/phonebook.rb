class PhoneBook
  def create
    print "Enter a file name for the new phone book: "
    file = STDIN.gets().chomp()
    FileUtils.touch(file)
    return file
  end
end

class Contact

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
      @phonebook = PhoneBook.new.select
    when 'c'
      @phonebook = PhoneBook.new.create
    when 'i'
      @phonebook.import
    when 'a'
      Contact.add_new(@phonebook)
    when 'f'
      Contact.new.find_by_name(@phonebook)
    when 'n'
      Contact.new.find_by_number(@phonebook)
    else
      puts 'Invalid choice'
    end
  end
end

if __FILE__ == $0
  Menu.new.show
end
