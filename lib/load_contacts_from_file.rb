require 'json'
class LoadContactsFromFile
  class << self
    # Loads contacts from a file
    #
    # @param [String] path the full path to the file
    def load(path)
      raise "Expected file path" unless path.kind_of? String
      raise "File doesn't exist" unless File.exists?(path)
      contacts_data = JSON.parse(IO.read(path))
      contacts = build_contacts_from_json(contacts_data)
      save_contacts(contacts)
    end

    # Takes the json data from the loaded file and parses through it
    #
    # @param [Hash] data the json parse results of the hash - expected to have fields:
    #   - name, sex, age, birthday, phone, email, address { street, city, state, postcode }
    def build_contacts_from_json(data)
      ret = []
      data.each do |c|
        contact = ContactSI.new do |csi|
          csi.set_contact = c
          csi.set_addresses = c['address']
        end
        ret << contact
      end
      ret
    end

    # Validates and persists the contacts to the database
    #
    # @param [Array] contacts an array of Contact objects with child address objects
    def save_contacts(contacts)
      errors = []
      contacts.each do |c|
        errors << c.errors unless c.save
      end
      errors
    end

  end
end
