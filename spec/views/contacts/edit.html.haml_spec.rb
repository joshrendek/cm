require 'spec_helper'

describe "contacts/edit" do
  before(:each) do
    @contact = assign(:contact, stub_model(Contact,
      :name => "MyString",
      :sex => "MyString",
      :age => "",
      :phone => "MyString",
      :email => "MyString"
    ))
  end

  it "renders the edit contact form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", contact_path(@contact), "post" do
      assert_select "input#contact_name[name=?]", "contact[name]"
      assert_select "input#contact_sex[name=?]", "contact[sex]"
      assert_select "input#contact_age[name=?]", "contact[age]"
      assert_select "input#contact_phone[name=?]", "contact[phone]"
      assert_select "input#contact_email[name=?]", "contact[email]"
    end
  end
end
