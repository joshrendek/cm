class Address < ActiveRecord::Base
  # todo: Add more validation for proper states later
  validates_presence_of :street, :city, :postcode, :state
  belongs_to :contact
end
