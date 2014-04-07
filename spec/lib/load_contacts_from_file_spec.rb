require 'litespec_helper'
require './app/models/contact'
require './lib/load_contacts_from_file'

describe LoadContactsFromFile do
  context "error conditions" do
    it "should get a path as a string" do
      expect { LoadContactsFromFile.load(:"/foo/bar/baz") }.to raise_error("Expected file path")
    end

    it "expects a file to exist" do
      expect { LoadContactsFromFile.load("/tmp/non-existant-file") }.to raise_error("File doesn't exist")
    end

    it "expects a valid json file" do
      expect { LoadContactsFromFile.load("spec/test_files/bad_json.json") }.to raise_error
    end
  end

  context "saving contacts" do
    it "should save the contacts" do
      LoadContactsFromFile.should_receive(:build_contacts_from_json)
      LoadContactsFromFile.should_receive(:save_contacts)
      LoadContactsFromFile.load('spec/test_files/articulate-data.json')
    end
  end

  context "valid contacts" do
    before { Contact.destroy_all }
    it "should load contacts and save them" do
      contacts = LoadContactsFromFile.load('spec/test_files/articulate-data.json')
      Contact.count.should eq(3)
    end
  end
end
