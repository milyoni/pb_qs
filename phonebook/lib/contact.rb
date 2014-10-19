class Contact
  attr_accessor :phonebook
  NUMBER = 2
  NAME = 1
  INDEX = 0

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

  def update
    index = find_by_name(true)
    print "Enter new number: "
    number = STDIN.gets().chomp()
    lines = CSV.read(@phonebook.phonebook)
    @phonebook.write("wb") do |csv|
      lines.each do |line|
        line[NUMBER] = number if line[INDEX] == index
        csv << line
      end
    end
  end

  def find_by_name(get_index=false)
    print "Enter name to find: "
    name = STDIN.gets().chomp().downcase()
    find NAME, name
    if get_index
      print "Enter index number to change: "
      return STDIN.gets().chomp()
    end
  end

  def find_by_number
    print "Enter number to find: "
    number = STDIN.gets().chomp().downcase()
    find NUMBER, number
  end

  private
  def print_entry(line)
    puts line.values_at(0, 2, 1).join( "\t" )
  end

  def find(key, item)
    CSV.read(@phonebook.phonebook).each do |line|
      print_entry line if /#{item}/ === line[key].downcase
    end
  end
end
