require 'spec_helper'

describe Contact do
  describe "sanitizing avatar urls" do
    it "should only allow safe urls" do
      c = Contact.new(avatar_url: "http://images.desimartini.com/media/uploads/kung_fu_panda200.jpg")
      c.valid?
      c.errors.messages[:avatar_url].should be_nil
    end

    it "should invalidate bad urls" do
      c = Contact.new(avatar_url: "foob://ar.9999")
      c.valid?
      c.errors.messages[:avatar_url].should eq(['is invalid'])
    end

  end
end
