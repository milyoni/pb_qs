require 'spec_helper'

describe "Menu" do
  describe "#show" do
    it "should take user input as a letter and process it" do
      any_instance_of(Menu) do |m|
        mock(m).process("a")
        mock(m).process("q")
      end
      mock(STDIN).gets() {"A\n"}
      mock(STDIN).gets() {"q\n"}
      Menu.new.show
    end
  end

  describe "#process" do
    before do
      @menu = Menu.new
    end

    def run_menu
      @menu.process('p')
      @menu.process('i')
      @menu.process('a')
      @menu.process('d')
      @menu.process('u')
      @menu.process('f')
      @menu.process('n')
      @menu.process('q')
      @menu.process('c')
      @menu.process('s')
    end

    describe "when a phonebook isn't open" do
      it "should only allow creating and quitting" do
        any_instance_of(PhoneBook) do |pb|
          dont_allow(pb).print_book
          dont_allow(pb).import
          mock(pb).create
          mock(pb).select
        end
        any_instance_of(Contact) do |c|
          dont_allow(c).add_new
          dont_allow(c).find_by_name
          dont_allow(c).find_by_number
        end

        run_menu
      end
    end

    describe "when a phonebook is open" do
      before do
        @menu.phonebook = PhoneBook.new
      end
      it "should allow all actions" do
        any_instance_of(PhoneBook) do |pb|
          mock(pb).create
          mock(pb).select
        end
        
        pb = @menu.phonebook
        mock(pb).print_book
        mock(pb).import
        mock(Contact).add_new(pb)

        any_instance_of(Contact) do |c|
          mock(c).initialize(pb).times(2)
          mock(c).find_by_name
          mock(c).find_by_number
        end

        run_menu
      end
    end
  end
end
