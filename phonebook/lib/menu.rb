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
    puts "Current phone book: #{@phonebook.phonebook}" if @phonebook
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
