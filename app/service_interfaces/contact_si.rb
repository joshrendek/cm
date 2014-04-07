# use this service interface to interact with contacts
# it will compose both the contact object and the address objects together and
# handle any business logic for the contacts and addresses
class ContactSI
  attr_accessor :contact, :addresses
  def initialize(&block)
    yield self
  end

  def set_contact=(v)
    binding.pry
    self.contact = Contact.new(v.except(:address))

    # importing from json file - otherwise its a rails form
    if v.has_key?('birthday')
      self.contact.birthday = DateTime.strptime(v['birthday'], "%m/%d/%Y")
    end

    self.contact
  end

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

  def save
    # can put other business rules here to notify other users etc or start background processes
    # to handle new contact saves
    contact.addresses = self.addresses
    contact.save!
    contact
  end


end
