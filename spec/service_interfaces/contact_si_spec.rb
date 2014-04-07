require 'litespec_helper'
require './app/models/address'
require './app/models/contact'
require './app/service_interfaces/contact_si'

describe ContactSI do
  describe "setting up a contact" do
    it "should set the contact object up" do
      c = ContactSI.new do |csi|
        csi.set_contact = {name: 'Foo Bar'}
      end
      c.contact.name.should eq('Foo Bar')
    end

    it "should set the address object" do
      c = ContactSI.new do |csi|
        csi.set_addresses = {street: 'Coffee'}
      end
      c.addresses.first.street.should eq('Coffee')
    end

    it "should persist to the db" do
      c = ContactSI.new do |csi|
        csi.set_contact = {name: 'Foo Bar'}
        csi.set_addresses = {street: 'Coffee'}
      end
      Contact.any_instance.should_receive(:save!)
      c.save
    end
  end
end
