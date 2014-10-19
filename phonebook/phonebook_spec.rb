require 'rspec'
require './phonebook'

RSpec.configure do |config|
  config.mock_with :rr
end

describe "Phonebook" do
  describe "#create" do
    it "should create a new phonebook"
  end

  describe "#select" do
    it "should allow the user to select the current phonebook"
  end

  describe "#print" do
    it "should print all the contacts in the current phonebook"
  end

  describe "#import" do
    it "should import a given csv file"
    it "should not overwrite existing phonebook entries"
  end
end

describe "Contact" do
  describe "#add_new" do
    it "should add the given entry to the current phonebook"
    it "should print an error and not "
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
    describe "when a phonebook isn't open" do
      it "should only allow creating and quitting"
    end
    describe "when a phonebook is open" do
      it "should allow all actions"
    end
  end
end
