#STATE = {
#  phonebook: nil,
#}
class PhoneBook

end


class Menu
  def show
    input = nil
    while !input || input != 'q'
      display_menu
      input = STDIN.gets.chomp.downcase
      process input
    end
  end

  def display_menu
  end

  def process(input)

  end
end

if __FILE__ == $0
  Menu.new.show
end
