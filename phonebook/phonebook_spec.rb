require 'tempfile'
require 'rspec'
require './phonebook'

RSpec.configure do |config|
  config.mock_with :rr
end

describe "Phonebook" do
  describe "#create" do
    it "should create a new phonebook" do
      tempfile = Tempfile.new(['foo', '.pb'])
      path = tempfile.path
      tempfile.close
      tempfile.unlink
      begin
        mock(STDIN).gets() {path}
        expect( File.exists?(path) ).to be false

        pb = PhoneBook.new
        pb.create
        
        expect( File.exists?(path) ).to be true
        expect(pb.phonebook).to eql path
      ensure
        File.delete(path)
      end
    end
  end

  describe "#select" do
    it "should allow the user to select the current phonebook" do
      mock(STDIN).gets {'x'}
      pb = PhoneBook.new
      pb.select

      expect(pb.phonebook).to eql 'x'
    end
  end

  describe "#print_book" do
    it "should print all the contacts in the current phonebook" do
      begin
        tempfile = Tempfile.new(['foo', '.pb'])
        tempfile.write("test data")
        tempfile.close
        mock(File).read(tempfile.path)

        PhoneBook.new(tempfile.path).print_book
      ensure
        tempfile.unlink
      end
    end
  end

  describe "#import" do
    it "should import a given csv file"
    it "should not overwrite existing phonebook entries"
  end
end

describe "Contact" do
  describe "#add_new" do
    it "should add the given entry to the current phonebook"
    it "should print an error and not add the entry"
  end

  describe "#delete" do
    it "should not be implemented right now as it was not asked for"
    it "should be brought up with product manager"
  end

  describe "#update" do
    it "should allow the user to update a contact's number by name"
  end

  describe "#find_by_name" do
    it "should look up numbers given a name"
  end

  describe "#find_by_number" do
    it "should look up names given a number"
  end
end

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
