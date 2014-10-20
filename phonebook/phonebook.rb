$LOAD_PATH.unshift '.'
require 'lib/phonebook'
require 'lib/menu'
require 'lib/contact'


if __FILE__ == $0
  Menu.new.show
end
