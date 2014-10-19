class Contact
  def self.add_new(phonebook)
    print "Enter new name: "
    name = STDIN.gets().chomp()
    print "Enter new number: "
    number = STDIN.gets().chomp()
    phonebook.add_entry(name, number)
  end
  def find_by_name

  end
  def find_by_number

  end
end
