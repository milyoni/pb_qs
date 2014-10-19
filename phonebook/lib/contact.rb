class Contact
  attr_accessor :phonebook

  def initialize(pb)
    @phonebook = pb
  end

  def self.add_new(phonebook)
    print "Enter new name: "
    name = STDIN.gets().chomp()
    print "Enter new number: "
    number = STDIN.gets().chomp()
    phonebook.add_entry(name, number)
  end

  def find_by_name
    print "Enter name to find: "
    name = STDIN.gets().chomp()
    CSV.read(@phonebook.phonebook).each do |line|
      if /#{name}/ === line[1].downcase
        puts line.values_at(0, 2, 1).join( "\t" )
      end
    end
  end

  def find_by_number

  end
end
