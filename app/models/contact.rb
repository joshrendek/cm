require 'digest/md5'
class Contact < ActiveRecord::Base
  validates_uniqueness_of :name
  validates_presence_of :name, :sex, :age, :birthday, :phone, :email
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  validates :age, inclusion: { in: 1..150 }
  validates :sex, inclusion: { in: %w{male female} }
  has_many :addresses

  def avatar(size = 20)
    md5 = Digest::MD5.hexdigest(email).to_s
    "http://www.gravatar.com/avatar/#{md5}.jpg?s=#{size}"
  end
end
