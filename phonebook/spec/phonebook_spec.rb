require 'spec_helper'

describe "Phonebook" do
  describe "#create" do
    it "should create a new phonebook" do
      tempfile = Tempfile.new(['foo', '.pb'])
      path = tempfile.path
      tempfile.close
      tempfile.unlink
      begin
        mock(STDIN).gets() {path + "\n"}
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
      mock(STDIN).gets {'x' + "\n"}
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
    it "should import a given csv file, adding to existing data" do
      def setup(test_data, existing_data)
        csv = write_temp_csv('foo.csv', test_data)
        pb_file = write_temp_csv('foo.pb', existing_data)

        mock(STDIN).gets() {csv.path + "\n"}

        return csv, pb_file
      end
      begin
        test_data = [["test","data"]]
        existing_data = [["1","existing","data"]]
        output = existing_data +[["2"] + test_data[0]]

        csv, pb_file = setup(test_data, existing_data)

        pb = PhoneBook.new(pb_file.path)
        pb.import

        expect( CSV.read(pb_file.path) ).to eql output
      ensure
        csv.unlink
        pb_file.unlink
      end
    end
  end
end

