require 'spec_helper'

describe "Contact" do
  before do
    @data = [
      ["1", "Cara Larson", "000-000-0001"],
      ["2", "Tiffaney Reynosa", "000-000-0002"],
      ["3", "Blythe Barba", "000-000-0003"],
      ["4", "Florene Haliburton", "000-000-0004"],
      ["5", "Christene Hittle", "000-000-0011"],
      ["6", "Emilee Lanning", "000-000-0012"],
      ["7", "Hiroko Lackey", "000-000-0013"],
      ["8", "Ila Duggins", "000-000-0014"],
    ]
  end
  describe "#add_new" do
    it "should add the given entry to the current phonebook" do
      begin
        csv = write_temp_csv('x.pb', @data)
        pb = PhoneBook.new(csv.path)
        mock(STDIN).gets() {"My name\n"}
        mock(STDIN).gets() {"123-555-1212\n"}
        output = @data + [['9', 'My name', '123-555-1212']]

        Contact.add_new(pb)

        expect( CSV.read(csv.path) ).to eql output
      ensure
        csv.unlink
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

  describe "search for contacts" do
    before do
      csv = write_temp_csv('x.pb', @data)
      pb = PhoneBook.new(csv.path)
      @contact = Contact.new(pb)
    end

    describe "#find_by_name" do
      it "should look up numbers given a name" do
        mock(STDIN).gets() { "hiroko\n"}
        mock(STDOUT).puts("7\t000-000-0013\tHiroko Lackey")

        @contact.find_by_name()
      end

      it "should look up numbers given a name partial name" do
        mock(STDIN).gets() { "ON\n"}
        mock(STDOUT).puts("1\t000-000-0001\tCara Larson")
        mock(STDOUT).puts("4\t000-000-0004\tFlorene Haliburton")

        @contact.find_by_name()
      end
    end

    describe "#find_by_number" do
      it "should look up names given a number" do
        mock(STDIN).gets() { "000-000-0013\n"}
        mock(STDOUT).puts("7\t000-000-0013\tHiroko Lackey")

        @contact.find_by_number()
      end
      it "should look up names given a partial number" do
        mock(STDIN).gets() { "3\n"}
        mock(STDOUT).puts("3\t000-000-0003\tBlythe Barba")
        mock(STDOUT).puts("7\t000-000-0013\tHiroko Lackey")

        @contact.find_by_number()
      end
    end
  end
end


