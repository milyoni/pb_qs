require 'spec_helper'

describe "Contact" do
  describe "#add_new" do
    it "should add the given entry to the current phonebook" do
      begin
        csv = write_temp_csv('x.pb', ["x"])
        pb = PhoneBook.new(csv.path)
        mock(STDIN).gets() {"My name\n"}
        mock(STDIN).gets() {"123-555-1212\n"}
        output = [['x'], ['2', 'My name', '123-555-1212']]

        Contact.add_new(pb)

        expect( CSV.read(csv.path) ).to eql output
      ensure
        #csv.unlink
      end
    end
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


