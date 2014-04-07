class Contact < ActiveRecord::Base
  validates_presence_of :name, :sex, :age, :birthday, :phone, :email
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  validates :age, inclusion: { in: 1..150 }
  validates :sex, inclusion: { in: %w{male female} }
  has_many :addresses
end
