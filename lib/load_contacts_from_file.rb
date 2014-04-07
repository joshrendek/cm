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

    # Builds up the address objects for use in a Contact object
    #
    # @param [Hash|Array] address_obj can accept either an array of addresses or a single address hash
    def build_addresses(address_obj)
      if address_obj.kind_of? Hash
        return [
          Address.new(
            street: address_obj['street'], city: address_obj['city'],
            state: address_obj['state'], postcode: address_obj['postcode']
          )
        ]
      elsif address_obj.kind_of? Array
        # todo: handle multiple addresses later
      end
    end

    # Takes the json data from the loaded file and parses through it
    #
    # @param [Hash] data the json parse results of the hash - expected to have fields:
    #   - name, sex, age, birthday, phone, email, address { street, city, state, postcode }
    def build_contacts_from_json(data)
      ret = []
      data.each do |c|
        date = DateTime.strptime(c['birthday'], "%m/%d/%Y")
        contact = Contact.new(name: c['name'], sex: c['sex'], age: c['age'],
                           birthday: date, phone: c['phone'],
                           email: c['email'],
                           addresses: build_addresses(c['address']))
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
