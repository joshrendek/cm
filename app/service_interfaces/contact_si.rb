# use this service interface to interact with contacts
# it will compose both the contact object and the address objects together and
# handle any business logic for the contacts and addresses
class ContactSI
  attr_accessor :contact, :addresses
  # Setup the contacts and addresses with a block
  # Example usage:
  # ContactSI.new do |c|
  #   c.set_contact(params_hash)
  #   c.set_addresses(addr_hash)
  # end
  def initialize(&block)
    yield self
  end

  # Set the contact attr based on the params passed in - no persistence is done yet
  def set_contact=(v)
    self.contact = Contact.new(v.except('address'))

    # importing from json file - otherwise its a rails form
    if v.has_key?('birthday')
      self.contact.birthday = DateTime.strptime(v['birthday'], "%m/%d/%Y")
    end

    self.contact
  end

  # Build address based on the data inputted - can be either an array or a single hash
  def set_addresses=(v)
    self.addresses = build_addresses(v)
  end

  # Builds up the address objects for use in a Contact object
  #
  # @param [Hash|Array] address_obj can accept either an array of addresses or a single address hash
  def build_addresses(v)
    # only create on address
    if v.kind_of? Hash
      return [Address.new(v)]
      # create multiple addresses
    elsif v.kind_of? Array
      # todo: multiple addresses
    end
  end

  # Persist to the database and throw an error on any exceptions
  # Any extra business logic would be put here instead of in the model
  def save
    # can put other business rules here to notify other users etc or start background processes
    # to handle new contact saves
    contact.addresses = self.addresses
    # can get rid of bang, depends on how we want to bubble up exceptions
    contact.save!
    contact
  end


end
